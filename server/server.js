var express = require('express'),
    app     = express();

var SDBcontroller = require('./Controllers/SDBController'),
    MDBcontroller = require('./Controllers/MDBController'),
    S3controller  = require('./Controllers/S3Controller');

var fs = require('fs');
fs.readFile('test.jpg', function(err, data) {
	request = {
		params: {email:"cool.jpg"},
		body:data
	};
	S3controller.postUserPic(request);
});

// app.post('/login',SDBcontroller.login);
// app.post('/checkin',SDBcontroller.checkin);
app.get('/listFollowers/:email',MDBcontroller.listFollowers);
app.get('/getUserPic/:email',S3controller.getUserPic);
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
app.post('/postUserPic',S3controller.postUserPic);
var server = app.listen(2015, function() {
    console.log('Server is working!');
});
