#!/usr/bin/env python2
# -*- coding: UTF-8 -*- 
# Distribution setup file
#-----------------------------------------------------------------------------

try:
    from setuptools import setup, find_packages, Command
except ImportError:
    from ez_setup import use_setuptools
    use_setuptools()
    from setuptools import setup, find_packages, Command

try:
    import os,stat, re, sys, platform,shutil, inspect, difflib
    import subprocess
    from os.path import abspath, dirname, join
    from esky import bdist_esky
    from setuptools import setup, find_packages,Command
    from distutils.core import setup
    from cx_Freeze import setup, Executable

	#from distutils.command.build_py import build_py
	#from distutils.command.sdist import sdist
	#from disutils.core import setup
	#from distutils.core import setup
	#import py2exe

except ImportError,e :
    raise e

    #example archlinux
    #https://www.archlinux.org/packages/community/any/python2-distutils-extra/

    #return None
    #sys.path.insert(0, '.')
    #print "Try to install dependences .."

except Exception, e:
	raise e

from pkg_resources import require, DistributionNotFound, VersionConflict

try:
    import DistUtilsExtra.auto
except ImportError:
    print >> sys.stderr, 'To build erpmtics_agent you need https://launchpad.net/python-distutils-extra'
    sys.exit(1)
assert DistUtilsExtra.auto.__version__ >= '2.18', 'needs DistUtilsExtra.auto >= 2.18'

#sys.exit(0)
#Variables

os_type = sys.platform 
os_sys = platform.system()

#
# Run the build process by running the command 'python setup.py build'

application_title = "erpmtics_socketio" #application to be called
main_python_file = "main.py" #the name of the python file you use to run the program
version = '0.1'

def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

DESC = "Provide a task for upload to cloud data on bash "
LONG_DESC = read('README.md')


includes = ["atexit","re"]   


requires = [
    'setuptools'
    ,'ez_setup'
    ,'bbfreeze'
    ,'cx_Freeze'
    ,'python-daemon'
    ,'zc.lockfile'
    ,'beefish'
    ,'APScheduler'
    ,'shovel'
    , 'invoke'
    , 'Paver'
    , 'doit'
    ,'docutils'
    ,'PyDrive'
    ]

# Build the app and the esky bundle
setup(
	install_requires= requires
    ,test_suite="nose.collector"
    ,tests_require="nose"
    #doit #python2 setup.py develop
	,packages=find_packages(exclude=['tests']) # manual packages=['core',''] A much better option is to use the find_packages function
    ,platforms = ['linux'] #Posix; MacOS X; Windows
	,name =application_title
	,version = version
	,description=DESC
    ,classifiers=[
        "Programming Language :: Python"
        ,"Topic :: Internet :: WWW/HTTP :: WSGI :: Application"
        ,'Framework :: erpmtics'
    ]
    ,include_package_data=True
    ,long_description=LONG_DESC
    ,keywords='erpmtics, python, manager it'
    ,author='Armando Ibarra'
    ,author_email='armandoibarra1@gmail.com'
    ,maintainer='Armando Ibarra'
    ,maintainer_email='armandoibarra1@gmail.com'
    ,license=('GPL license with a special exception which allows to use '
             'erpmtics to build and distribute non-free programs '
             '(including commercial ones)')
    ,url='http://artpcweb.appspot.com'
    ,download_url='http://artpcweb.appspot.com/projects/erpmtics/erpmtics_socketio'
    ,zip_safe=False
    ,entry_points = 
    {
        'console_scripts': [
            'erpmtics_socketio = erpmtics_socketio.app:main'
        ]
        ,'setuptools.installation': [
            'erpmtics_socketio = erpmtics_socketio.app:main',
        ]
    }

	)