var express = require('express');
var util = require('util');
var app = express();

var SDBcontroller = require('./Controllers/SDBController.js');
//var S3controller  = require('./Controllers/S3Controller');

//user?email=weiqian.pku@gmail.com
app.get('/user', SDBcontroller.get_user);
//user?email=weiqian.pku@gmail.com&password=weiqian&name=WeiqiAn
app.post('/user', SDBcontroller.add_user);
//app.put('/user',  SDBcontroller.add_user);

//http://localhost:2015/checkin?email=weiqian.pku@gmail.com&location=123&text=helloworld
app.get('/checkin', SDBcontroller.get_checkin);
app.post('/checkin', SDBcontroller.post_checkin);

app.get('/follow', SDBcontroller.get_follow);
app.post('/follow', SDBcontroller.post_follow);
app.delete('/follow', SDBcontroller.delete_follow);

// app.get('/getUserPic/:email',S3controller.getUserPic);
// app.post('/getUserPic/:email',S3controller.getUserPic);

var server = app.listen(2015, function() {
    console.log('Server is working!');
});
