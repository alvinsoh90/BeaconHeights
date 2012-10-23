
var mysql      = require('mysql');
var client;
var dbName;
//var logger = require('nlogger').logger(module);
//var bcrypt = require('bcrypt');
//var salt = bcrypt.gen_salt_sync(10);

/*
 * Method for connecting to MySQL DB 
 */
exports.connect = function(ip, dbname, username, pass) {
	client = mysql.createClient({
		//user: 'root',
		user: username,
		password: pass,
		host: ip,
		port: '3306'
	});

	dbName = dbname;
};

/*
 * Returns all block and block information
 */
exports.getAllBlocks = function(callback){
	var sqlString = "SELECT * FROM lin_db.block";

	client.query(sqlString, function(err, rows, fields) {
	  if (err) {
	  	console.log(err);
		return callback(err, null);
	  }
	  else{
	  	return callback(null,rows);
	  }
	  
	});
};

exports.getUserHash = function(callback,username){
	var sqlString = "SELECT password FROM lin_db.user WHERE user_name = '"+username+"'";

	client.query(sqlString, function(err, rows, fields) {
	  if (err) {
	  	console.log(err);
		return callback(err, null);
	  }
	  else{
	  	return callback(null,rows[0]);
	  }
	  
	});
};

exports.getUserRole = function(callback,username){
	var sqlString = "SELECT name FROM lin_db.role WHERE id =(SELECT role_id FROM lin_db.user WHERE user_name = '"+username+"')";
	
	client.query(sqlString, function(err, rows, fields) {
	  if (err) {
	  	console.log(err);
		return callback(err, null);
	  }
	  else{
	  	return callback(null,rows[0]);
	  }
	  
	});
};

exports.getNonAdminUsers = function(callback){
	var sqlString = "SELECT `user_id`, `user_name`, `role_id`, `DOB`, `block_id`, `level`, `unit`, `facebook_id` FROM lin_db.user WHERE role_id<>1";
	
	client.query(sqlString, function(err, rows, fields) {
	  if (err) {
	  	console.log(err);
		return callback(err, null);
	  }
	  else{
	  	return callback(null,rows);
	  }
	  
	});
};

exports.getAllUsers = function(callback){
	var result = {"success": false,"error": null};
	var sqlString = "SELECT `user_id`, `user_name`, `role_id`, `DOB`, `block_id`, `level`, `unit`, `facebook_id` FROM lin_db.user";
	var firstResult;
	client.query(sqlString, function(err, rows, fields) {
	  if (err) {
	  	console.log(err);
		return callback(err, null);
	  }
	  else{
	  	result.success=true;
	  	result['result']=rows;
	  	return callback(null,result);
	  }
	  
	});
};

exports.getAllTempUsers = function(callback){
	var sqlString = "SELECT `user_id`, `user_name`, `role_id`, `DOB`, `block_id`, `level`, `unit`, `facebook_id` FROM lin_db.user_temp";
	client.query(sqlString, function(err, rows, fields) {
	  if (err) {
	  	console.log(err);
		return callback(err, null);
	  }
	  else{
	  	if(rows.length==0){
	  		var result = {"isNull": "true"};
	  		return callback(null,result);
	  	}else{
	  		return callback(null,rows);
	  	}
	  }
	  
	});
};

exports.doesUserExist = function(callback,username){
	var sqlString = "SELECT user_name FROM (SELECT user_name FROM lin_db.user UNION SELECT user_name FROM lin_db.user_temp) As all_users WHERE user_name='"+username+"'";
	var result;

	client.query(sqlString, function(err, rows, fields) {
	  if (err) {
	  	console.log(err);
		return callback(err, null);
	  }
	  else{
	  	if(rows.length>0){
	  		result = {"userExists": "true"};
	  	}else{
	  		result = {"userExists": "false"};
	  	}
	  	return callback(null,result);
	  }
	  
	});
};

exports.addTempUser = function(callback,userInfo){
	var info=userInfo.split(",");
	var sqlString = "INSERT INTO `lin_db`.`user_temp` (`user_id`, `password`, `user_name`, `firstname`, `lastname`, `role_id`, `DOB`, `block_id`, `level`, `unit`, `facebook_id`) VALUES (NULL, '"+info[1]+"', '"+info[0]+"', '"+info[2]+"', '"+info[3]+"', '2', NULL, '"+info[4]+"', '"+info[5]+"', '"+info[6]+"', NULL)";
	client.query(sqlString, function(err) {
	  if (err) {
	  	console.log(err);
		return callback(err);
	  }
	  else{
	  	return callback(200);
	  }
	  
	});
};

exports.approveTempUser = function(callback,userId){
	var result = {"success": false,"error": null};
	var sqlString = "SELECT * from lin_db.user_temp WHERE user_id='"+userId+"'; INSERT INTO lin_db.user (password,user_name,firstname,lastname,role_id,DOB,block_id,level,unit,facebook_id) SELECT password,user_name,firstname,lastname,role_id,DOB,block_id,level,unit,facebook_id FROM lin_db.user_temp WHERE lin_db.user_temp.user_id='"+userId+"'; DELETE FROM lin_db.user_temp WHERE user_id='"+userId+"'; commit;"
	console.log("HELLO LOOK HERE! "+sqlString+"END OF THINOBGR");
	client.query(sqlString, function(err,rows,fields) {
	  if (err) {
	  	console.log(err);
		return callback(err,null);
	  }
	  else{
	  	if(rows.length>0){
	  		result.success=true;
	  		result['result']=rows;
	  	}
	  	return callback(null,result);
	  }
	  
	});
};


