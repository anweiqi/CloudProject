var AWS = require('aws-sdk');
AWS.config.loadFromPath('awscredentials');
var s3 = new AWS.S3();
var s3Bucket = new AWS.S3( { params: {Bucket: 'myBucket'} } );

module.exports.getUserPic = function(req,res){
	var email = req.params.email;
	var urlParams = {Bucket: 'userpicscloud', Key: email};
	s3Bucket.getSignedUrl('getObject', urlParams, function(err, url){
		//console.log('the url of the image is', url);
		console.log(email);
		res.send(url);
	})
}