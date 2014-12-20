var MongoClient = require('mongodb').MongoClient,
 	format		= require('util').format;


module.exports.listFollowers = function(email, res) {
	MongoClient.connect('mongodb://127.0.0.1:27017/test', function(err, db) {
    	if(err) console.log(err,err.stack);
    	var collection = db.collection(email);
      	collection.find().toArray(function(err, results) {
      		if(err) console.log(err,err.stack);
        		res.send(results);
        		db.close();
		});
	});
}