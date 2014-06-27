// Establish the connection with the server

var x ="test grunt file ";
//sockethandler
if (typeof sockethandler == 'undefined') { var sockethandler = {}; }

var socket = io.connect();
socket.on("gotData", function(data,id) {
   var element=document.getElementById(id);
   var view=element.getAttribute("view");
   if(sockethandler[view]) $(element).html(sockethandler[view](data));
})

sockethandler.view1=function(data) {
 return "The message is:"+data.message;
}

sockethandler.view2=function(data) {
 return "The result is:"+data.result;
}
$(function() {
  $.each($(".socketview"),function(el,i) {
    socket.emit(el.getAttribute("service"),           JSON.parse(el.getAttribute("params")),
     el.id);
  });
});

var socket = io.connect(document.location.href);





//este es un test de buil
/*


//var socket = io.connect("http://127.0.0.1:8080");
 
$(window).bind("beforeunload", function() {
            socket.disconnect();
});
 
socket.on('new_update', function (msg) {
            var el = $('#log').prepend($('<p class="update">').append($('<em>').text(msg))).css("color", "#FF0000");
            $("#log .update").first().animate({color: '#000000'}, 3500);
});
 
socket.on('worker_connected', function (msg) {
            var el = $('#log').prepend($('<p>').append($('<b>').text(msg)));
});
 
socket.on('worker_disconnected', function (msg) {
            var el = $('#log').prepend($('<p>').append($('<b>').text(msg)));
});

*/
 
//when documento is ready
$(document).ready(function() {

    console.log("Init app");
    //Sidebar
    $.slidebars();

});

