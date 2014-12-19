var url = require("url");
var exports = module.exports = {};
var simpledb = require('simpledb');

var aws_access_key = 'AKIAISVALTJIES4I5XYQ';
var aws_secret_key = '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';

var sdb = new simpledb.SimpleDB({keyid:aws_access_key, secret:aws_secret_key});

exports.add_user= function(req, res) {
    var params = url.parse(req.url, true).query;
    sdb.putItem('userinfo', params.email, {password:params.password, name:params.name}, function( error ) {
        if(error){
            console.log(error);
        }
    });
};

exports.login= function(req, res) {
    var params = url.parse(req.url, true).query;
    sdb.putItem('userinfo', params.email, {password:params.password, name:params.name}, function( error ) {
        if(error){
            console.log(error);
        }
    });
};

exports.logout= function(req, res) {
    var params = url.parse(req.url, true).query;
    sdb.putItem('userinfo', params.email, {password:params.password, name:params.name}, function( error ) {
        if(error){
            console.log(error);
        }
    });
};

exports.search_user= function(req, res) {
    var params = url.parse(req.url, true).query;
    if (params.email != undefined) {
        sdb.select("select * from userinfo where itemName() = '" + params.email + "'", function( error, result, meta ){
            console.log(result);
            res.send(result);
        });
    }else if (params.name != undefined) {
        sdb.select("select * from userinfo where name = '" + params.email + "'", function( error, result, meta ){
            if(error){
                res.status(404).send('Not found');
            }
            console.log(result);
            res.send(result);
        });
    }
};

exports.check_in = function(req,res) {
    var shopcart = req.session.shoppingcart;
    if(shopcart == undefined){
        res.send([]);
    }else{
        query = "select * from catalog where itemName() =";
        for(i=0; i<shopcart.length-1;i++){
            query = query + "'"+ shopcart[i] + "' or itemName() = ";
        }
        query = query + "'"+ shopcart[shopcart.length-1] + "'";
        sdb.select(query, function(error, result, meta){
            if(error){
                res.send({error: 1});
            }else{
                res.send(result);
            }
        })
    }
};

exports.add_to_cart = function(req,res) {
    var params = url.parse(req.url, true).query;
    if(req.session.shoppingcart == undefined){
        req.session.shoppingcart = [];
    }
    req.session.shoppingcart.push(params.product);
    res.send({error: 0});
};

/*exports.remove_from_cart = function(req,res) {
    var params = url.parse(req.url, true).query;
    if(req.session.shoppingcart == undefined){
        req.session.shoppingcart = [];
    }
    req.session.shoppingcart.push(params.product);
    res.send({error: 0});
};*/

exports.product_search = function(req,res) {
    var params = url.parse(req.url, true).query;
    var query = '';
    if(params.category == "all"){
        query = "select * from catalog";
    }else{
        query = "select * from catalog where category = '"+params.category+"'";
    }
    var searchResult = [];
    sdb.select(query, function(error, result, meta){
        if(error){
            res.send({error: 1});
        }else{
            if(params.keyword == ''){
                res.send(result);
            }else{
                result.forEach(function(item) {
                    if(item.name.indexOf(params.keyword) > -1){
                        searchResult.push(item);
                    }
                });
                res.send(searchResult);
            }
        }
    })
};

exports.get_recommend = function(req,res) {
    var params = url.parse(req.url, true).query;
    if(req.session.viewHistory == undefined || req.session.viewHistory.length == 0){
        get_first(res, 6);
    }else{
        var total = req.session.viewHistory.length;
        var last = req.session.viewHistory[total-1];
        var secondToLast = req.session.viewHistory[total-2];
        var recommendation = [];
        sdb.select("select * from catalog where itemName() = '"+last+"'",function(error, result, meta){
            if(error){
                res.send({error: 1});
            }else{
                var lastCategory = result[0].category;
                sdb.select("select * from catalog where category = '"+lastCategory+"' limit 3",function(error, result, meta){
                    if(error){
                        res.send({error: 1});
                    }else{
                        recommendation = result;
                        sdb.select("select * from catalog where itemName() = '"+secondToLast+"'",function(error, result, meta){
                            if(error){
                                res.send({error: 1});
                            }else{
                                var secondToLastCategory = result[0].category;
                                sdb.select("select * from catalog where category = '"+secondToLastCategory+"' limit 3",function(error, result, meta){
                                    if(error){
                                        res.send({error: 1});
                                    }else{
                                        result.forEach(function(item) {
                                            recommendation.push(item);
                                        });
                                        res.send(recommendation);
                                    }
                                })
                            }
                        })
                    }
                })
            }
        })
    }
};

get_first = function(res, limit){
    sdb_query("select * from catalog limit "+limit, res);
}

/*sdb.deleteDomain('catalog',function(err,res,meta) {
    if (!err) {
        console.log('Domain catalog is deleted');
    }
});*/

sdb.createDomain('catalog', function( error ) {
    if(error){
        console.log("Error in creating domain");
    }
});

sdb_query = function(query, res){
    sdb.select(query,function(error, result, meta){
        if(error){
            res.send({error: 1});
        }else{
            res.send(result);
        }
    })
}

//"['test@user.com', 'TO-NA-Tho', 1]"
/*var last= 'TO-NA-Tho';

sdb.select("select * from catalog where category = 'clothing'",function( error, result, meta ){
    //console.log("error:");
    //console.log(error);
    var field = '$ItemName';
    console.log("result:");
    console.log(result[0]['$ItemName']);
    //console.log("meta:");
    //console.log(meta);
})*/

