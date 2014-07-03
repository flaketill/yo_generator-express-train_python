#!/usr/bin/env python
# -*- coding: UTF-8 -*- 
# -*- encoding: utf-8 -*-

###############################################################################
# Copyright (C) 2014 Armando Ibarra
# app for upload data to google drive v0.1 alpha - 2014-May-19

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
# main.py
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

import sys, os, datetime,time

# Library imports
import signal,subprocess,atexit,tempfile
#optparse is deprecated; you should use argparse in both python2 and python3
import logging
import warnings,errno
import exceptions
import logging,re

logging.basicConfig()
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

logger.debug("Test")

import httplib2
import pprint
import sys

from config.settings import APP_ID
from core.websocket_client import SocketIOProvider as socket

def main(args=sys.argv):
    """The main function for the erpmtics_agent program."""
    logger.debug(args)

    try:
        logger.debug("Init the app %s" % APP_ID)

        sock = socket()
        sock.io_connect()
        #sock.on("welcome")
        sock.emit("msn", "io_connect with python app")
        #sock.emit("msn", "update_app")

        sock.app()

        #sock.emit("msn", "msn_test")
        #sock.emit("msn", "msn_test tets 2")


    except ImportError:
        raise
    except KeyboardInterrupt: # close all websockets
        sock.disconnect() 
    except Exception, e:
        raise    

if __name__ == '__main__':
    main()    