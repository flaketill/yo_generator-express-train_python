/*jslint node: true */
"use strict";

//*************************************
//
// socketio app
//
//**************************************

//module dependencies

module.exports = function(app, config) {
   
    console.log("[express train application listening on %s]", config.port);

    // development only
	if ("development" == app.get("env")) 
	{
		//app.use(express.errorHandler());
		console.log("[erpmtics: app on dev:: Init socket io ]");

		// logs every request, this is like:
		// debug - client authorized
		// info  - handshake authorized XXXXXXXXXXXXXXXXXXXX
		// debug - setting request GET /socket.io/1/websocket/XXXXXXXXXXXXXXXXXXXX
		// debug - set heartbeat interval for client XXXXXXXXXXXXXXXXXXXX
		// debug - client authorized for 

		app.use(function(req, res, next){
			// output every request in the array
			console.log({method:req.method, url: req.url, device: req.device});
			// goes onto the next function in line
			next();
		});

	}

	// all environments
	app.set("port", process.env.PORT || 3001);

	var server = require("http").createServer(app).listen(app.get("port"), function(){

		console.log("Express server listening on port: " + app.get("port"));
	});

    var io = require("socket.io").listen(server);

    io.sockets.on("connection", function (socket) {

		io.sockets.emit("msn", {msg:"connected"});

		socket.on("msn", function(data, fn){
			console.log(data);
			io.sockets.emit("msn", {msg:data.msg});

			fn();//call the client back to clear out the field
		});

	});


    return app.listen(config.port);
};