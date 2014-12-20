var express = require('express');
var util = require('util');
var app = express();

app.get('/user', function(req, res){
    var params = url.parse(req.url, true).query;
    console.log(params);
});

var SDBcontroller = require('./Controllers/SDBController'),
    MDBcontroller = require('./Controllers/MDBController'),
    S3controller  = require('./Controllers/S3Controller');

// app.post('/login',SDBcontroller.login);
// app.post('/checkin',SDBcontroller.checkin);
app.get('/listFollowers/:email',MDBcontroller.listFollowers);
app.get('/getUserPic/:email',S3controller.getUserPic);
app.post('/getUserPic/:email',S3controller.getUserPic);
var server = app.listen(2015, function() {
    console.log('Server is working!');
});
