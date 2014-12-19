var express = require('express');
var http = require('http');
var url = require("url");
var util = require('util');
var app = express();

app.get('/user', function(req, res){
    var params = url.parse(req.url, true).query;
    console.log(params);
});

var server = app.listen(2015, function() {
    console.log('Server is working!');
});
