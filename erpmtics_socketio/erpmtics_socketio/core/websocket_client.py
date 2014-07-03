#!/usr/bin/env python
# -*- coding: UTF-8 -*- 
# -*- encoding: utf-8 -*-

###############################################################################
# Copyright (C) 2014 Armando Ibarra
# app for send data form python(use websocket) to socketio (node) v0.1 alpha - 2014-July-02

# ========================
# Software and source code
# ========================

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version. 

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>

# For details on authorship, see AUTHORS, Licese copy GNU, see LICENSE

#----------------------------------------------------------------------
# websocket io + python + wrapper (/usr/lib/python2.7/site-packages/websocket.py)
#
# Created: 07/02/2014
#
# Author: Ing. Armando Ibarra - <armandoibarra1@gmail.com>
#----------------------------------------------------------------------

#/usr/share/applications
###############################################################################

#-----------------------|
# Import Python Modules |
#-----------------------|
import websocket 
#/usr/lib/python2.7/site-packages/websocket.py
#WARNING if you have installed https://pypi.python.org/pypi/websocket-client/ --> on /usr/lib/python2.7/site-packages/websocket/__init__.py -->
#from websocket import create_connection
import thread
import time
import sys
from urllib import *

import asyncore
import socket
import struct
import time
from hashlib import sha1
from base64 import encodestring
import json
import simplejson as json

#I do not know if I'll use this module but if I use it is because:

#I'd like"Stop Reinventing The Wheel"
#DON’T REINVENT THE WHEEL! USE A FRAMEWORK!
from socketIO_client import SocketIO

from time import sleep
from datetime import datetime

import httplib,logging
from socketIO_client import SocketIO, BaseNamespace


# from erpmtics_socketio.config.settings import SOCKET_IO_HOST
# from erpmtics_socketio.config.settings import SOCKET_IO_PORT

#from config.settings import SOCKET_IO_HOST
#from config.settings import SOCKET_IO_PORT

SOCKET_IO_HOST = "localhost"
SOCKET_IO_PORT = 3001

import logging

logging.basicConfig()
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

class SocketIOProvider(object):
    """Class like wrapper or facade WebSocket"""
    def __init__(self, strategy=None):
    	self.debug = False      
        self.action = None
        self.count = 0

        self.ws = None
        self.socketio_url = None

        logger.info("Init socket io with websocket")

    def io_connect(self):
        """Conect Test or get Sec-WebSocket-Key - hskey
        wsdump.py ws://localhost:3001/socket.io/1/ -vv
        """

        self.ws = websocket.WebSocket()

        logger.info("connecting to: %s:%d" %(SOCKET_IO_HOST, SOCKET_IO_PORT))
        conn  = httplib.HTTPConnection(SOCKET_IO_HOST + ':' + str(SOCKET_IO_PORT))
        conn.request('POST','/socket.io/1/')
        resp  = conn.getresponse() 
        hskey = resp.read().split(':')[0]
        _onopen = None
        _onmessage = None

        #print hskey
        #should be like
        #ws://localhost:3001/socket.io/1/websocket/0E2FrTzTlL6rjQb8mOQM
        self.socketio_url = SOCKET_IO_URL = 'ws://' + SOCKET_IO_HOST + ':' + str(SOCKET_IO_PORT) + '/socket.io/1/websocket/'+hskey
        #print SOCKET_IO_URL
        
        #print(dir(websocket.WebSocket()))

        #ws = websocket.create_connection("ws://echo.websocket.org/")
        #ws = websocket.WebSocket()
        # ws = websocket.WebSocket()

        # result = websocket.WebSocket(SOCKET_IO_URL ,_onopen,_onmessage)

        try:
            self.ws.connect(SOCKET_IO_URL)    
            print "Successfully connected to: %s"%(SOCKET_IO_URL)   
        except Exception, e:
            #raise e
            logger.info("I can connect withs %s" % SOCKET_IO_URL)

        # sys.exit()    

        # # - websocket writing 5:::{"name":"msn","args":[{"msg":"connected"}]}
        # ws.send('5:1::{"name":"msn", "args":[{"msg":"connected from python"}]}')
        # #ws.send('5:1::{"name":"newimg", "args":"bla"}')
        # #opcode, data = ws.recv()
        # #print data
        # recv_data = ws.recv_data()

        # print recv_data


        # print "Reeiving..."
        # result =  ws.recv()
        # print "Received '%s'" % result

        # frame = ws.recv_frame()

        # if not frame:
        #     raise websocket.WebSocketException("Not a valid frame %s" % frame)
        # elif frame.opcode:
        #     #return (frame.opcode, frame.data)
        #     #print frame.opcode
        #     print "Received ------> '%s'" % frame.data
        #     print frame.data
        #     import simplejson as json

        #     #d = json.loads(frame.data)
        #     #print d['glossary']['title']

        # elif frame.opcode == websocket.ABNF.OPCODE_CLOSE:
        #     ws.send_close()
        #     #return (frame.opcode, None)
        #     print frame.opcode
        # elif frame.opcode == websocket.ABNF.OPCODE_PING:
        #     ws.pong("Hi!")
        #     #return frame.opcode, frame.dats
        #     pass

    def on(self,mns):
        """on"""
        logger.info("Plase wait, Searching updates ..")
        for i in range(3):
            time.sleep(1)
            msn = "........................................ %d percent" % i
            logger.info(msn)
            #self.ws.send("Plase wait, Searching updates ..... %d" % i)
            time.sleep(1)
        #self.ws.close()        
        thread.start_new_thread(self.on("ok"), ())

    def emit(self,name,args):
        """emit"""
        logger.info("emit")

        data = '5:1::{"name":"%s", "args":[{"msg":"%s"}]}' % (name, args)
        # message = {'message': {
        #     'name':'armando',
        #     'type':'x',
        #     'value':25 } }
        # self.ws.send(json.dumps(message))
        #data = { "name":"%s", "args":[{"msg":"%s"}] }  % (name, args)
        #msn = json.dumps( data )
        #self.ws.send(msn)

        logger.info(data)
        #self.heartbeat()
        self.ws.send(data)        
        asyncore.loop()
        #self.ws.send('5:1::{"name":"msn", "args":[{"msg":"connected from python by on"}]}')
        pass

    def heartbeat(self):
        logger.info("Sending heartbeat ")
        self.ws.send("2::")

    def decode(self,data):
        """Decode """
        frame = bytearray(data)
        length = frame[1] & 127
        indexFirstMask = 2

        if length == 126:
            indexFirstMask = 4
        elif length == 127:
            indexFirstMask = 10

        indexFirstDataByte = indexFirstMask + 4
        mask = frame[indexFirstMask:indexFirstDataByte]

        i = indexFirstDataByte
        j = 0
        decoded = []

        while i < len(frame):
            decoded.append(frame[i] ^ mask[j%4])
            i += 1
            j += 1

        print decoded
        return "".join(chr(byte) for byte in decoded)

    # Stolen from http://stackoverflow.com/questions/8125507/how-can-i-send-and-receive-websocket-messages-on-the-server-side
    def decodeCharArray(self, stringStreamIn):
    
        # Turn string values into opererable numeric byte values
        byteArray = [ord(character) for character in stringStreamIn]
        datalength = byteArray[1] & 127
        indexFirstMask = 2
 
        if datalength == 126:
            indexFirstMask = 4
        elif datalength == 127:
            indexFirstMask = 10
 
        # Extract masks
        masks = [m for m in byteArray[indexFirstMask : indexFirstMask+4]]
        indexFirstDataByte = indexFirstMask + 4
        
        # List of decoded characters
        decodedChars = []
        i = indexFirstDataByte
        j = 0
        
        # Loop through each byte that was received
        while i < len(byteArray):
        
            # Unmask this byte and add to the decoded buffer
            decodedChars.append( chr(byteArray[i] ^ masks[j % 4]) )
            i += 1
            j += 1
 
        # Return the decoded string
        return decodedChars        

    def on_message(self, ws, message):
        #msg = json.loads(message)
        #data = msg["message"]
        #// on connection to server, anonymous callback
        #socket.on('welcome', function(data){
        self.heartbeat()
        logger.info("################################################ INIT server message ################################################")
        logger.info(message)        
        logger.info("Reeiving datas...")

        #£££££££££££££££ WARNING: Just test this method is stupid for decode message get from websocket#################
        #£££££££££££££££ No production, just dev #################
        msgs = message.split('\xff')
        logger.info("Reeiving datas 1...")
        logger.info(msgs)
        logger.info("Reeiving datas 3...")
        m = message.strip().split('\"')
        logger.info(m)
        logger.info("Reeiving datas 4...")
        #logger.info(m.length)
        for x in m:
            if x == "2::":
                logger.info(x)
            elif x == "msg":
                logger.info(m[9])
                if m[9] == "update_app":
                    logger.info("Please wait, update apps")
                    #self.on("update")
                    #open erpmtics_agent
                    import subprocess
                    command = 'erpmtics_agent'
                    subprocess.call(command)

        return

        logger.info("################################################ /END server message ################################################")        

    def on_error(self, ws, error):
        logger.info("ERROR: {0}".format(error))

    def on_close(self,ws):
        print "### closed ###"

    def on_open(self, ws):
        logger.info("Opened WebSocket connection ..")
        pass

    def disconnect(self):
        """disconnect form WebSocket"""
        logger.info("terminating WebSocket connection ..")
        self.ws.close()

    def app(self):
        websocket.enableTrace( True )
        app = websocket.WebSocketApp(self.socketio_url,
                              on_message = self.on_message,
                              on_error = self.on_error,
                              on_close = self.on_close)
        app.on_open = self.on_open
        app.run_forever()
