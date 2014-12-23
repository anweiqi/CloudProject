var express = require('express');
var util = require('util');
var fs = require('fs');
var app = express();

var SDBcontroller = require('./Controllers/SDBController.js');
//var S3controller  = require('./Controllers/S3Controller');

SDBcontroller.simpleDBInit();

//http://localhost:2015/login?email=weiqian@gmail.com&password=weiqian
app.get('/login', SDBcontroller.login);

//http://localhost:2015/user?email=weiqian@gmail.com
app.get('/user', SDBcontroller.get_user);
//http://localhost:2015/user?email=weiqian@gmail.com&password=weiqian&name=WeiqiAn
app.post('/user', SDBcontroller.add_user);
app.put('/user',  SDBcontroller.update_user);

//http://localhost:2015/checkin
//http://localhost:2015/checkin?email=weiqian@gmail.com
app.get('/checkin', SDBcontroller.get_checkin);
//http://localhost:2015/checkin?email=weiqian@gmail.com&latitude=30&longitude=80&text=helloworld
app.post('/checkin', SDBcontroller.post_checkin);

//http://localhost:2015/follow?email=weiqian@gmail.com
app.get('/follow', SDBcontroller.get_follow);
//http://localhost:2015/follow?email=weiqian@gmail.com&follower=jiuyang@gmail.com
app.post('/follow', SDBcontroller.post_follow);
//http://localhost:2015/follow?email=weiqian@gmail.com&follower=jiuyang@gmail.com
app.delete('/follow', SDBcontroller.delete_follow);

// app.get('/getUserPic/:email',S3controller.getUserPic);
// app.post('/getUserPic/:email',S3controller.getUserPic);


// fs.readFile('test.jpg', function(err, data) {
// 	request = {
// 		params: {email:"cool.jpg"},
// 		body:data
// 	};
// 	S3controller.postUserPic(request);
// });

//app.get('/getUserPic/:email',S3controller.getUserPic);
//app.post('/postUserPic',S3controller.postUserPic);

app.get('/test',function(req,res) {
	var test = [
		{
			color: "red",
			value: "#f00"
		},
		{
			color: "green",
			value: "#0f0"
		},
		{
			color: "blue",
			value: "#00f"
		},
		{
			color: "cyan",
			value: "#0ff"
		},
		{
			color: "magenta",
			value: "#f0f"
		},
		{
			color: "yellow",
			value: "#ff0"
		},
		{
			color: "black",
			value: "#000"
		}
	];
	res.send(test);
});

var server = app.listen(2015, function() {
    console.log('Server is working!');
});
