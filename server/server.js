var express = require('express');
var http = require('http');
var url = require("url");
var util = require('util');
var app = express();
var session = require("express-session");
var redis = require('redis');
var RedisStore = require('connect-redis')(session);
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

//var client = redis.createClient();

app.all('*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", req.headers.origin);
    res.header("Access-Control-Allow-Credentials", true);
    next();
});

app.use(session({
    store: new RedisStore({
        host: 'localhost',
        port: 6379,
        ttl: 1000000000000
        //client: client
    }),
    cookie: {maxAge: 360000000000, httpOnly: false},
    secret: '1234567890QWERTY'
}));

app.use(cookieParser('1234567890QWERTY'));
app.use(bodyParser());
app.use(bodyParser.urlencoded({extended: true}));

app.engine('html', require('ejs').renderFile);
app.use("/js", express.static(__dirname + '/public/js'));
app.use("/images", express.static(__dirname + '/public/images'));
app.use("/views", express.static(__dirname + '/views'));
app.use("/semantic", express.static(__dirname + '/public/semantic'));

app.use(multer({dest: './uploads/'}));

app.set('view engine', 'html');

/*app.get('/', function(req, res) {
    if(req.session.currentUser){
        res.render('index',{myVar : req.session.currentUser});
    }else{
        res.render('index',{myVar : null});
    }
});*/


//loginAPI
app.get('/login', function(req, res){
    var params = url.parse(req.url, true).query;
    console.log(params);
});


var server = app.listen(2015, function() {
    console.log('Server is working!');
});
