
/** ============= GLOBAL VARS ============= **/
var ROOT = '/api/';
var SITE_IP = 'http://106.187.95.45';
// DB vars
//var DB_IP = '106.187.95.45';
var DB_IP = "127.0.0.1";
var DB_NAME = 'lin_db';
var DB_USER = "root";
var DB_PASS = 'Charisfyp!';
/** ============= END GLOBAL VARS ============= **/

/** ============= DEPENDENCIES ============= **/
var db_func = require('./lib/dbfunctions');
var http = require('http');
var express = require('express');
var log4js = require('log4js');
log4js.configure({
    appenders: [
        { type: 'console' },
        { type: 'file', filename: 'logs/node.log' }
    ]
});
var logger = log4js.getLogger();
logger.setLevel('INFO');
/** ============= END DEPENDENCIES ============= **/

/* ============= INIT SERVER ============= */
var app = express();

app.configure(function() {
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(log4js.connectLogger(logger, { level: log4js.levels.INFO }));
  app.use(app.router);
});



db_func.connect(DB_IP, DB_NAME, DB_USER, DB_PASS);
/* ============= END INIT SERVER ============= */


/* ============= API ROUTES ============= */

app.get(ROOT, function(req, res){
  res.send('Hello World');
});

app.get(ROOT + 'getAllBlocks', function(req, res){
  
  db_func.getAllBlocks(function(err,result){
    if(err){
      console.log("error in db call: "+err);
      res.send(500,err);
    }
    else{
      res.send(200,JSON.stringify(result));
      logger.warn("Test warn")
    }
  });

});

app.get(ROOT + 'getUserHash/:username', function(req, res){
  
  console.log(req.params.username);

  db_func.getUserHash(function(err,result){
    if(err){
      console.log("error in db call: "+err);
      res.send(500,err);
    }
    else{
      res.send(200,JSON.stringify(result));
      logger.warn("Test warn")
    }
  },req.params.username);
});

app.get(ROOT + 'getUserRole/:username', function(req, res){
  
  console.log(req.params.username);

  db_func.getUserRole(function(err,result){
    if(err){
      console.log("error in db call: "+err);
      res.send(500,err);
    }
    else{
      res.send(200,JSON.stringify(result));
      logger.warn("Test warn")
    }
  },req.params.username);
});

app.get(ROOT + 'getNonAdminUsers', function(req, res){
  
  console.log(req.params.username);

  db_func.getNonAdminUsers(function(err,result){
    if(err){
      console.log("error in db call: "+err);
      res.send(500,err);
    }
    else{
      res.send(200,JSON.stringify(result));
      logger.warn("Test warn")
    }
  });
});

app.get(ROOT + 'getAllUsers', function(req, res){
  
  console.log(req.params.username);

  db_func.getAllUsers(function(err,result){
    if(err){
      console.log("error in db call: "+err);
      res.send(500,err);
    }
    else{
      res.send(200,JSON.stringify(result));
      logger.warn("Test warn")
    }
  });
});

app.get(ROOT + 'doesUserExist/:username', function(req, res){
  
  console.log(req.params.username);

  db_func.doesUserExist(function(err,result){
    if(err){
      console.log("error in db call: "+err);
      res.send(500,err);
    }
    else{
      res.send(200,JSON.stringify(result));
      logger.warn("Test warn")
    }
  },req.params.username);
});

app.get(ROOT + 'addTempUser/:userInfo', function(req, res){
  
  console.log(req.params.username);

  db_func.addTempUser(function(err,result){
    if(err){
      console.log("error in db call: "+err);
      res.send(500,err);
    }
    else{
      res.send(200,JSON.stringify(result));
      logger.warn("Test warn")
    }
  },req.params.userInfo);
});


app.listen(3000);
console.log('Listening on port 3000');