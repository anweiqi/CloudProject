var express = require('express');
var http = require('http');
var url = require("url");
var util = require('util');
var app = express();
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

//var client = redis.createClient();

app.all('*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", req.headers.origin);
    res.header("Access-Control-Allow-Credentials", true);
    next();
});

app.use(bodyParser());
app.use(bodyParser.urlencoded({extended: true}));

app.engine('html', require('ejs').renderFile);
app.use("/javascript", express.static(__dirname + '/public/js'));
app.use("/images", express.static(__dirname + '/public/images'));
app.use("/views", express.static(__dirname + '/views'));
app.use("/semantic", express.static(__dirname + '/public/semantic'));

app.use(multer({dest: './uploads/'}));

app.set('view engine', 'html');

//loginAPI
app.get('/login', function(req, res){
    var params = url.parse(req.url, true).query;
    console.log(params);
});


var server = app.listen(2015, function() {
    console.log('Server is working!');
});
