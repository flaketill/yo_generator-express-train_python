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
var socket = io.connect(document.location.href);
//var socket = io.connect("http://localhost:3001/");
//var app = app || {};
//var socket = io.connect(document.location.href);

//setup some common vars (cache)
var video = $('#video')
    ,updates = $('h1')
    ,msn_test = "testing socket io python and node";//"armando";

    var message =  function message (message) 
    {
        console.log(message);
    };        
 
    socket.on("msn", function(data){

        console.log("Datas:" + data.msg);

        $('#log').html("User connected");        

    });

    // on connection to server, anonymous callback
    socket.on('welcome', function(data){

        console.log("44: Datas:" + data.msg);

        $('#log').html("New User connected");
        //SOCKET STUFF
        socket.emit("msn", {msg:msn_test}, function(data){
            console.log(data);
            console.log("Send datas jaja");
            console.log("58: Datas:" + data.msg);
        });

    });

     // listener, whenever the server emits update_list
    socket.on('update_list', function(data) {

        console.log("Update lits");
        console.log(data);

        $('#log').html(data);

        message('client disconnected');
        /*$('#log').empty();
        
        $.each(data, function(key, value) {
            $('#log').append('<div>' + key + '</div>');
        });*/
    });

    //Test clint send to server 
    video.click(function(e){

        socket.emit("msn", {msg:msn_test}, function(data){
          console.log("Send datas");
        });
      
    });

    //Test clint send to server 
    updates.click(function(e){

        socket.emit("msn", {msg:"update_app"}, function(data){
          console.log("Send datas");
        });
      
    });  

//when documento is ready
$(document).ready(function() {

    console.log("Init app");
    //Sidebar
    $.slidebars();

    $('#log').focus().click();
});

