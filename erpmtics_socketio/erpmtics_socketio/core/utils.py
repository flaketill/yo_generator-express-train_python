try:
    import os,stat, re, sys, platform,shutil, inspect, difflib
    import subprocess,imp    
    from os.path import abspath, dirname, join
    #from abc import ABCMeta, abstractmethod

    import sys, os, datetime, wxversion
    import logging
    import gtk 
    import webkit

except ImportError:
    #return None
    print "Try to install dependences .."

except Exception, e:
    raise e

def os_type():
    """
        Linux (2.x and 3.x) 'linux2'
        Windows 'win32'
        Windows/Cygwin  'cygwin'
        Mac OS X    'darwin'
        OS/2    'os2'
        OS/2 EMX    'os2emx'
        RiscOS  'riscos'
        AtheOS  'atheos'

        os_type = sys.platform 
        os_sys = platform.system()
    """
    os_2= None
    os_type = sys.platform 
    os_sys = platform.system()

    #print os_type #linux2
    #print os_sys #Linux

    if sys.platform.startswith('freebsd'):
        # FreeBSD-specific code here...
        #print "-----utils --------BSD"
        os_2 = "bsd"
    elif sys.platform.startswith('linux') and os_sys =="Linux" and os.name == 'posix':
        # Linux-specific code here...
        #print "-----utils --------linux"
        os_2 = "linux"
    elif sys.platform.startswith("win32") and os.name == 'nt':
        #print "-----utils --------Windows"
        os_2 = "win"
    elif sys.platform.startswith("darwin"):
        #print "-----utils --------MAc OS X"
        os_2 = "macosx"
    elif sys.platform.startswith("sunos"):        
        #print "-----utils --------Sun OS "
        os_2 = "sunos"
    return os_2