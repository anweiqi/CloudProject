var url = require("url");
var exports = module.exports = {};
var simpledb = require('simpledb');

var aws_access_key = 'AKIAISVALTJIES4I5XYQ';
var aws_secret_key = '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';

var sdb = new simpledb.SimpleDB({keyid:aws_access_key, secret:aws_secret_key});

exports.login= function(req, res) {
    var params = url.parse(req.url, true).query;
    sdb.select("select * from userinfo where itemName() = '" + params.email + "'", function( error, result, meta ){
        if(error){
            console.log(error);
            res.status(403).send('Incorrect email/password');
        }else{
            if(result[0].password == params.password){
                res.send(result[0]);
            }else{
                res.status(403).send('Incorrect email/password');
            }
        }
    });
};

exports.add_user= function(req, res) {
    var params = url.parse(req.url, true).query;
    sdb.select("select * from userinfo where itemName() = '" + params.email + "'", function( error, result, meta ){
        if(error){
            res.status(404).send('Unknown Error');
            console.log(error);
        }else if(result.length){
            res.status(403).send('User exists');
        }else{
            sdb.putItem('userinfo', params.email, {password:params.password, name:params.name}, function( error ) {
                if(error){
                    res.status(404).send('Unknown Error');
                    console.log(error);
                }else{
                    res.send({error:0});
                }
            });
        }
    });
};

exports.update_user= function(req, res) {
    var params = url.parse(req.url, true).query;
    sdb.putItem('userinfo', params.email, {password:params.password, name:params.name}, function( error ) {
        if(error){
            res.status(404).send('Unknown Error');
            console.log(error);
        }else{
            res.send({error:0});
        }
    });
};

exports.get_user= function(req, res) {
    var params = url.parse(req.url, true).query;
    if (params.email != undefined) {
        sdb.select("select * from userinfo where itemName() = '" + params.email + "'", function( error, result, meta ){
            if(error){
                console.log(error);
                res.status(404).send('Not found');
            }else{
                console.log(result);
                res.send(result);
            }
        });
    }else if (params.name != undefined) {
        sdb.select("select * from userinfo where name = '" + params.email + "'", function( error, result, meta ){
            if(error){
                console.log(error);
                res.status(404).send('Not found');
            }else{
                console.log(result);
                res.send(result);
            }
        });
    }else{
        sdb.select("select * from userinfo ", function( error, result, meta ){
            if(error){
                console.log(error);
                res.status(404).send('Not found');
            }else{
                console.log(result);
                res.send(result);
            }
        });
    }
};

exports.post_checkin = function(req,res) {
    var params = url.parse(req.url, true).query;
    console.log(params);
    sdb.putItem('checkin', (new Date()).toString(), {latitude:params.latitude, longitude:params.longitude, email:params.email, time:(new Date()).getTime(), text: params.text}, function( error ) {
        if(error){
            console.log(error);
        }else{
            res.send({error:0});
        }
    });
};

exports.get_checkin = function(req,res) {
    // var params = url.parse(req.url, true).query;
    // console.log(params);
    // sdb.putItem('checkin', (new Date()).toString(), {location:params.location, email:params.email, time:(new Date()).getTime(), text: params.text}, function( error ) {
    //     if(error){
    //         console.log(error);
    //     }
    // });

    var params = url.parse(req.url, true).query;
    if (params.email != undefined) {
        sdb.select("select * from checkin where email = '" + params.email + "'", function( error, result, meta ){
            console.log(result);
            res.send(result);
        });
    }else{
        sdb.select("select * from checkin", function( error, result, meta ){
            console.log(result);
            res.send(result);
        });
    }
};

exports.get_follow = function(req,res) {
    var params = url.parse(req.url, true).query;
    console.log(params);

    sdb.select("select * from follow where itemName() = '" + params.email + "'", function( error, result, meta ){
       if(error){
            console.log(error);
            res.status(404).send('Not found');
        }else{
            if (result.length == 0) res.send([]);
            else{
            console.log(result);
            var arrayResult = result[0].followList.split(",");
            var query = "select email, name from userinfo where itemName() = ";
            for(i=0; i<arrayResult.length-1;i++){
                query = query + "'" + arrayResult[i] + "' or itemName() =" ;
            }
            query = query +  "'" + arrayResult[i] + "'";
            sdb.select(query,  function( error, result, meta ){
                if(error){
                    console.log(error);
                    res.status(404).send('Not found');
                }else{
                    console.log(result);
                    res.send(result);
                }
            });
            //res.send(result);
            }
        }
    });
};

exports.post_follow = function(req,res) {
    var params = url.parse(req.url, true).query;
    console.log(params);

    sdb.select("select * from follow where itemName() = '" + params.email + "'", function( error, result, meta ){
       if(error){
            console.log(error);
            res.status(404).send('Not found');
        }else{
            var newResult;
            if(result.length){
                newResult = result[0].followList.split(",");
            }else{
                newResult = [];
            }
            newResult.push(params.follower);
            sdb.putItem('follow', params.email, {followList:newResult}, function( error ) {
                if(error){
                    console.log(error);
                    res.status(404).send('Not found');
                }else{
                    res.send({error:0});
                }
            });
        }
    });
};

exports.delete_follow = function(req,res) {
    var params = url.parse(req.url, true).query;

    sdb.deleteItem('follow',params.email,{ followList: params.follower}, function( error, result, meta ){
        if(error){
            console.log(error);
            res.status(404).send('Not found');
        }else{
            console.log(result);
            res.send(result);
        }
    });
};


// get_first = function(res, limit){
//     sdb_query("select * from catalog limit "+limit, res);
// }

// sdb.deleteDomain('checkin',function(err,res,meta) {
//     if (!err) {
//         console.log('Domain checkin is deleted');
//     }
// });

// sdb.createDomain('checkin', function( error ) {
//     if(error){
//         console.log("Error in creating domain");
//     }
// });


exports.simpleDBInit= function() {
    sdb.createDomain('userinfo', function( error ) {
        if(error){
            console.log("Error in creating domain");
        }
    });

    sdb.createDomain('checkin', function( error ) {
        if(error){
            console.log("Error in creating domain");
        }
    });

    sdb.createDomain('follow', function( error ) {
        if(error){
            console.log("Error in creating domain");
        }
    });
};

// sdb.createDomain('follow', function( error ) {
//     if(error){
//         console.log("Error in creating domain");
//     }
// });

// params = {email: "weiqian.pku@gmail.com", follower: "xiao@gmail.com"};

// sdb.select("select * from follow where itemName() = '" + params.email + "'", function( error, result, meta ){
//        if(error){
//             console.log(error);
//             res.status(404).send('Not found');
//         }else{
//             var follow_list = result[0].followList.split(",");
//             var query ="select * from userinfo where itemName() = '" ;

//             result.forEach(function(item){
//                 query = query + item +
//                 sdb.select("select * from userinfo where itemName() = '" + item + "'", function( error, user, meta ){
//                     if(error){
//                         console.log(error);
//                         res.status(404).send('Not found');
//                     }else{
//                         console.log(user);
//                         res.send(result);
//                     }
//                 });
//             });
//             console.log(result);
//             res.send(result);
//         }
//     });
