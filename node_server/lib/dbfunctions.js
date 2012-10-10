
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