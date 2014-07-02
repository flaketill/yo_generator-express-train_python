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
# websocket io + python + wrapper
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

#I do not know if I'll use this module but if I use it is because:

#I'd like"Stop Reinventing The Wheel"
#DON’T REINVENT THE WHEEL! USE A FRAMEWORK!
from socketIO_client import SocketIO

from time import sleep
from datetime import datetime

import httplib,logging
from socketIO_client import SocketIO, BaseNamespace


from config.settings import SOCKET_IO_HOST
from config.settings import SOCKET_IO_PORT

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
        SOCKET_IO_URL = 'ws://' + SOCKET_IO_HOST + ':' + str(SOCKET_IO_PORT) + '/socket.io/1/websocket/'+hskey
        #print SOCKET_IO_URL
        
        #print(dir(websocket.WebSocket()))

        #ws = websocket.create_connection("ws://echo.websocket.org/")
        #ws = websocket.WebSocket()
        # ws = websocket.WebSocket()

        # result = websocket.WebSocket(SOCKET_IO_URL ,_onopen,_onmessage)

        try:
            self.ws.connect(SOCKET_IO_URL)       
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
        logger.info("on")
        pass

    def emit(self,name,args):
        """emit"""
        logger.info("emit")

        data = '5:1::{"name":"%s", "args":[{"msg":"%s"}]}' % (name, args)

        logger.info(data)
        self.ws.send(data)
        asyncore.loop()
        #self.ws.send('5:1::{"name":"msn", "args":[{"msg":"connected from python by on"}]}')
        pass

    def on_message(ws, message):
        print message

    def on_error(ws, error):
        print error

    def on_close(ws):
        print "### closed ###"

    def on_open(ws):
        pass

    def run(*args):
        for i in range(3):
            time.sleep(1)
            ws.send("Hello %d" % i)
            time.sleep(1)
        ws.close()
        print "thread terminating..."
        thread.start_new_thread(run, ())

    def disconnect(self):
        """disconnect form WebSocket"""
        pass

    def app(self):
        app = websocket.WebSocketApp("ws://echo.websocket.org/",
                              on_message = on_message,
                              on_error = on_error,
                              on_close = on_close)
        app.on_open = on_open
        app.run_forever()
