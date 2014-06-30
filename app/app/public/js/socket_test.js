/*jslint node: true */
"use strict";

/*************************************
//
// socketio app
//
**************************************/
// connect to our socket server
//var socket = io.connect('http://127.0.0.1:4000/');
//http://localhost:1337/socket.io/socket.io.js


// Establish the connection with the server
//sockethandler
if (typeof sockethandler == "undefined") { var sockethandler = {}; }

//var socket = io.connect();
var socket = io.connect("http://localhost:3001/");
//var app = app || {};
//var socket = io.connect(document.location.href);

//when documento is ready
$(document).ready(function() {

    console.log("Init app");
    //Sidebar
    $.slidebars();

    //setup some common vars (cache)
    var video = $('#video')
        ,msn_test = "testing socket io python and node";//"armando";

    //SOCKET STUFF
    socket.on("msn", function(data){

      console.log("Datas:" + data.msg);

    });

    //Test clint send to server 
    video.click(function(e){

        socket.emit("msn", {msg:msn_test}, function(data){
          console.log("Send datas");
        });
      
    }); 

});

