# Example app build with generator-express-train
## Overview

This is app build with:

yo generator-express-train 

I add socketio and python client for test 

## Quick start

To quickly build your environment, then create a standalone EXE,
run the following commands:

## Prerequisites

* [Node](http://nodejs.org) 0.10.29 or later installed.

###Windows

npm install
node .


###Linux

    $ clone git https://github.com/flaketill/js/yo/generator-express-train/app_eg
    $ cd app_eg
    $ npm install
	$ node .

If you have a proble like: npm ERR! Error: EACCES, unlink

Please try running this command again as root/Administrator.

For eg on Ubuntu: sudo npm install 
Or ArchLinux without sudo: su -c "npm install"

deps 

sudo npm install -g grunt-cli

With port in use (For search)

sudo netstat -plan|grep :35729

for number conections:

sudo netstat -plan|grep :35729|awk {'print $5'}|cut -d: -f 1|sort|uniq -c|sort -nk 1|egrep "0.0.0.0|127.0.0.1"

If you are using Ubuntu, then you may need to `apt-get install nodejs-legacy` too.

You will need to run the install via sudo:

    sudo npm install -g grunt-cli

###Mac OS X

npm install
node .