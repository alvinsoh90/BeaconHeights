// DB vars
var DB_IP = '106.187.95.45';
var DB_NAME = 'lin_db';
var DB_PASS = 'Charisfyp!';

/*** END GLOBAL VARS **/

/** DEPENDENCIES **/
var mysql      = require('mysql');

var client = mysql.createClient({
user: 'root',
password: DB_PASS,
host: '127.0.0.1',
port: '3306'
});

//client.query('USE lin_db');

client.query('select * from lin_db.block', function(err, rows, fields) {
  if (err) throw err;
  console.log(""+rows);

});