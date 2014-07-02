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


	var message =  function message (message) 
	{
        console.log("Server received datas from clients");
    };


    var io = require("socket.io").listen(server);

    io.sockets.on("connection", function (socket) {
	//INIT     	

		socket.emit("welcome", {msg:"connected to server"});

		socket.on("msn", function(data){ //, //fn){

			console.log("63: Server received datas from clients");
			console.log(data);
			io.sockets.emit("msn", {msg:data.msg});
			//io.sockets.emit("msn", {msg:data});

			//call the client back to clear out the field
		});

		// when the user disconnects.. perform this , this listens and executes
		socket.on('disconnect', function() {

			console.log("78: User disconnect to Server");
		    
		    // update list of users in chat, client-side
		    //socket.emit('update_list',"SRE");
		    //socket.emit("welcome", {msg:"Diconnected to server"});		    

		    socket.broadcast.emit('update_list', 'User has disconnected');

		});    
	
	//END
	});


    return app.listen(config.port);
};