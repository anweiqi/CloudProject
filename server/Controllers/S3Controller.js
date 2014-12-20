// var AWS = require('aws-sdk');
// AWS.config.loadFromPath('awscredentials');
// var s3 = new AWS.S3();
// var s3Bucket = new AWS.S3( { params: {Bucket: 'myBucket'} } );

// module.exports.getUserPic = function(req,res){
// 	var email = req.params.email;
// 	var urlParams = {Bucket: 'userpicscloud', Key: email};
// 	s3Bucket.getSignedUrl('getObject', urlParams, function(err, url){
// 		//console.log('the url of the image is', url);
// 		console.log(email);
// 		res.send(url);
// 	})
// }
// module.exports.postUserPic = function(req,res){
// 	var email = req.params.email;
// 	var data = {Key: email, Body: req.body.image};
// 	s3Bucket.putObject(data, function(err, data){
//     	if (err) console.log('Error uploading data: ', data);
//     	else console.log('succesfully uploaded the image!';
// 	});
// }