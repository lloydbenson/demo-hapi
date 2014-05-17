var Async = require('async');
var Hapi = require('hapi');
var Hoek = require('hoek');

var internals = {

    defaults: {}
};

var server = Hapi.createServer('8888');

//var settings = Hoek.applyToDefaults(internals.defaults, options);

Async.series([
function (next) {
server.pack.require('hapi-examples', {}, next);
}], function (err) {
   if (err) {
      console.log(err);
      return;
   }
server.start(function() {
    console.log("Server started at: " + server.info.uri);
    var routingTable = server.table();
    var routes = [];
    for (var i = 0; i < routingTable.length; ++i) {
        
        //console.log(routingTable[i]);
        routes[i] = {
            method: routingTable[i].method,
            path: routingTable[i].path,
            description: routingTable[i].settings.description
        };
    }
    console.log(routes);
});
});
