#!/usr/bin/env sh
# -*- coding: UTF-8 -*- 
# Copyright (C) 2014 Armando Ibarra
#  v0.1 alpha - 2014
# 

#----------------------------------------------------------------------
# install https://github.com/invisibleroads/socketIO-client for testing 
# sockets with clients (Javascript and Python) and server with node (socket io)

# Author: Ing. Armando Ibarra - armandoibarra1@gmail.com
# Email: armandoibarra1@gmail.com
# Date: 13/06/2014 
# Purpose:
#    Performs the install socketIO-client
#    this shell script try to install depencences 
#    on linux OS, invokes some system commands like
#    sudo, pacman, apt-get install, etc
#
#----------------------------------------------------------------------
# NOTES:    
#----------------------------------------------------------------------
#  	 You can use this script from git:
# 	 curl -s https://raw.githubusercontent.com/flaketill/yo_generator-express-train_python/master/erpmtics_socketio/install_websocket_client.sh | sh
# 	 curl -s https://raw.githubusercontent.com/flaketill/yo_generator-express-train_python/master/erpmtics_socketio/install_websocket_client.sh | bash

#    Test on Archlinux
#----------------------------------------------------------------------

###############################################################################

# Licensed under the GNU GPL v3 - http://www.gnu.org/licenses/gpl-3.0.txt
# - or any later version.

# WPS install languages
# A bash script installing/building all needed dependencies to 
# build wps languages for just some Linux distributions.

# @author: Ing. Armando Ibarra

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

###############################################################################

#variables

#autor and project data
AUTHOR='Ing. Armando Ibarra <armandoibarra1@gmail.com>'
COPYRIGHT='Copyright (c) 2014, armandoibarra1@gmail.com'
LICENSE='GNU GPL Version 3'

WEB_SITE="https://github.com/flaketill/yo_generator-express-train_python"
VERSION_SCRIPT="0.0.1 alpha"

#colors bash script
GREEN="\033[1;32m"
RESET="\033[0m"
WHITE="\033[1;37m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"

THIS_SCRIPT_PATH=`readlink -f $0`
THIS_SCRIPT_DIR=`dirname ${THIS_SCRIPT_PATH}`
TMP_CONF=$HOME"/.erpmtics"

#421
PATH_PY_REQUERIMENTS=$THIS_SCRIPT_DIR"/requirements.txt"

DEPENDENCIES_ARCH="none"
DEPENDENCIES="sudo curl axel wget ssh yolk"
DEPENDENCIES_PIP="setuptools elementtree virtualenv2"
DEPENDENCIES_NPM=""
DEPENDENCIES_BOWER=""
DEPENDENCIES_TAR=""

DEPS_ALT="YES"
DEPS_PIP="YES"

DISTROS_SUPPORT="Arch Ubuntu Debian"
DISTRO="none"
PACKAGE_MANAGER="none"
MANAGER_SEARCH_PY_PKGS="none"

NAME_PROYECT="$THIS_SCRIPT_DIR/test"

## make sure dir exits; else create it
#[ -d ~/.config/erpmtics ] || mkdir -p ~/.config/erpmtics
if [ ! -d ~/.config/erpmtics ]; then
	mkdir -p ~/.config/erpmtics
fi

if [ -f ~/.config/erpmtics/erpmticsrc ]; then
	source ~/.config/erpmtics/erpmticsrc
else
	EDITOR=nano
fi

PYTHON_SITE_PKG=$(python2 -sSc 'import site; print site.getsitepackages()[0]')


error()
{
	echo -e "$RED ${PROGNAME}: ${1:-"Unknown Error"} $RESET" 1>&2

}

# An error exit function
error_exit()
{

	echo -e "$RED ${PROGNAME}: ${1:-"Unknown Error"} $RESET" 1>&2
	exit 1
}

show_msn_w()
{

	echo -e "$WHITE $1 $RESET"
}

show_msn_warn()
{

	echo -e "$RED $1 $RESET"
}

report_bug() 
{

  show_msn_warn "###############_::: Error detected ::: ##############"
  show_msn_w "Please file a bug report at  $BLUE ${WEB_SITE} $RESET"
  show_msn_w "Project: $BLUE erpmtics $RESET"
  show_msn_w "Scripts: $BLUE https://github.com/flaketill/yo_generator-express-train_python $RESET"
  show_msn_w "Component: $BLUE Packages $RESET"
  show_msn_w "Label: $BLUE erpmtics $RESET"
  show_msn_w "Version:  $BLUE $VERSION_SCRIPT $RESET"
  show_msn_w " "
  echo -e ""$GREEN"Please detail your operating system type, version and any other relevant details" ""$RESET""
}

# Check if command exists use  /usr/bin/yolk - returns 0 if it does, 1 if it does not
#Please, use this function just  when you search a specific package on system
check_pkg() 
{
  #This is recommend for all Posix systems.
  #Ref http://www.cyberciti.biz/faq/unix-linux-shell-find-out-posixcommand-exists-or-not/
  #if command -v $1 >/dev/null 2>&1
  #if ! which $dep &>/dev/null; then
  if command -v $1 >/dev/null 2>&1;then
    return 0
  else
    return 1
  fi
}

msn_unable_search_package() 
{
  show_msn_warn "Unable to search package!"
  show_msn_w "-----------------------------"
  report_bug
  exit 1
}

manager_downloader() 
{
  
  if check_pkg wget; then
    show_msn_w "existe wget"
    return 0
  elif check_pkg curl; then
    show_msn_w "existe curl"
    return 0
  elif check_pkg axel; then
    show_msn_w "existe axel"
    return 0
  elif check_pkg git; then
    #wget https: && return 0
    show_msn_w "existe git"
    return 0
  fi

  #if not exist show msn 
  msn_unable_search_package

}

manager_python_pkgs() 
{

	#i Use this because "Stop Trying to Reinvent the Wheel"
  	#Order to use, plese see more on: http://code.activestate.com/pypm/search:setuptools/
  	if check_pkg yolk; then
  		MANAGER_SEARCH_PY_PKGS="yolk"
    	return 0
  	elif check_pkg pip2; then #WRNING with /usr/bin/vendor_perl/pip
    	#wget https: && return 0
    	#pip2 freeze
    	MANAGER_SEARCH_PY_PKGS="pip2"
    	return 0
	elif check_pkg easy_install; then
		MANAGER_SEARCH_PY_PKGS="easy_install"
    	return 0
    else
    	MANAGER_SEARCH_PY_PKGS="manual"
    	return 0
  	fi

}

#yolk -l | grep "setuptools" 
# [armando@localhost site-packages]$ yolk -l | grep "setuptools" 
# setuptools      - 5.2          - active

#pip2 freeze | grep "set"
#pip2 freeze | grep "set"  ---> WARNIG not show setuptools WHY?
# Warning: cannot find svn location for Babel==1.3-20140317
# dataset==0.5.2
# ez-setup==0.9

#pkgutil
# pkgutil.walk_packages(path=None, prefix='', onerror=None)
#walk_packages()

#if exist pacman exec: sudo pacman -Qi python2
# [armando@localhost site-packages]$ pacman -Qi python2
# Nombre            : python2
# Versión           : 2.7.7-1
# Descripción       : A high-level scripting language


#Like this:
# [armando@localhost site-packages]$ yolk -l | grep "virtualenv" 
# 	virtualenv-clone - 0.2.5        - active 
# 	virtualenv      - 1.11.6       - active 
# 	virtualenvwrapper - 4.3          - active 
# [armando@localhost site-packages]$ which virtualenv2
# 	/usr/bin/virtualenv2

check_python_pkgs()
{
	#search manager for querying python packages installed on your system.
	manager_python_pkgs
	
	#show_msn_w "$LINENO --  search package $1 with $MANAGER_SEARCH_PY_PKGS $RESET"

	#manager python packages (search, install or others )
	case "$MANAGER_SEARCH_PY_PKGS" in
	#case "$1" in
  	'yolk')
			show_msn_w "Plase wait, search with yolk .."

			#pip install -U yolk -U | awk '{print $1}'
			#yolk -l | grep "setup" 

			#yolk2 -l | grep "virtualenv" | wc -l &>/dev/null
			#for evit línea 256: yolk2: no se encontró la orden (for test error)

			#py_yolk=$(yolk2 -l &>/dev/null | grep "virtualenv" | wc -l)---> always 0
			#py_yolk=$(yolk -l | grep "virtualenv" | wc -l)
			py_yolk=$(yolk -l | grep "$1" | wc -l)

			if [ $py_yolk -eq 1 ]; then
				show_msn_w "$GREEN #############Dependences it's OK ############# $RESET"
				return 0
		 	elif [ $py_yolk -gt 0 ]; then

		 		show_msn_w "I found this packages:"
		 		#search more specific
		 		exec yolk -l | grep "$1" | awk '{print $1}'

		 		return 1
		 		#if seacrh versions - yolk -l | grep "$1" | awk '{print $3}'          	
		 	else
		 		show_msn_w "$LINENO -- ERROR $RED I can't found dependences: $1 $RESET"    			
		 		return 1
		 	fi
  	;;
  	'pip2')
			show_msn_w "Plase wait, search with pip .."
  	;;
  	'easy_install')
			show_msn_w "Plase wait, search with easy_install.."
  	;;
  	'manual')
			show_msn_w "Plase wait, search manual .."
  	;;
 	*)
		#Manual
		#if not exist show msn 
  		msn_unable_search_package
		show_msn_w "$LINENO: Could not detect supported Linux distribution. Supported operating systems: $DISTROS_SUPPORT"
    	
  	;;
	esac
}

search_python_pkgs()
{
	check_python_pkgs $1 			
}

backup_virtualenvwrapper() 
{
    virtualenv_project="$1"
    cp -p $HOME/$virtualenv_project $HOME/${virtualenv_project}.pre-virtualenv
}

#search_python_pkgs virt
#if search with name general like virt
# [armando@localhost erpmtics_socketio]$ sh install_websocket_client.sh 
#  Plase wait, search with yolk .. 
#   #############Dependences it's OK #############  
#  I found this packages: 
# virtualenv-clone - 0.2.5        - active 
# virtualenv      - 1.11.6       - active 
# virtualenvwrapper - 4.3          - active 

run_virtualenvwrapper()
{
	#/usr/lib/python2.7/site-packages/virtualenvwrapper

	#https://docs.python.org/2/library/site.html
	#https://docs.python.org/3/library/site.html
	show_msn_w "Build virtualenv on $NAME_PROYECT"

	#configure virtualenvwrapper
	export VIRTUALENVWRAPPER_VIRTUALENV=virtualenv2
	#source /usr/bin/virtualenvwrapper.sh

	#Virtualenvwrapper
	# export WORKON_HOME=$HOME/.virtualenvs
	# export PROJECT_HOME=$HOME/Projects
	# source /usr/bin/virtualenvwrapper.sh

	export WORKON_HOME=$NAME_PROYECT/virtualenvs
	export PROJECT_HOME=$NAME_PROYECT

	#export PIP_VIRTUALENV_BASE=$WORKON_HOME # Tell pip to create its virtualenvs in $WORKON_HOME.
	#export PIP_RESPECT_VIRTUALENV=true # Tell pip to automatically use the currently active virtualenv.

	if [ ! -d $NAME_PROYECT ]; then
		mkdir -p $NAME_PROYECT
	fi

	PYTHON=$(which python2 ) #&>/dev/null)

	#if ! which $dep &>/dev/null;  then
	if test $? -eq 0;then
		show_msn_w "search python ..."
		show_msn_w $PYTHON

		PYTHON_SITE_PKG=$(python2 -sSc 'import site; print site.getsitepackages()[0]')

		if test $? -eq 0;then
			export VIRTUALENVWRAPPER_PYTHON=$PYTHON
			#export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv2
			#/usr/bin/virtualenv2
			#exit 0
		else
			#python3 ?
			
			PYTHON3=$(which python3 )
			if test $? -eq 0;then
				show_msn_w "I found python v3"

				PYTHON_SITE_PKG=$(python3 -m site --user-site)

				if test $? -eq 0;then
					show_msn_w "You use python3"
					export VIRTUALENVWRAPPER_PYTHON=$PYTHON3
					#export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv2
					#/usr/bin/virtualenv2
				fi
			fi

		fi

		
	fi

	#Default Arguments for virtualenv
	#~export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
	
	if [ -e "/usr/bin/virtualenvwrapper.sh" ];then
        show_msn_w "Found virtualenvwrapper.sh" >&2
        #sh /usr/bin/virtualenvwrapper.sh

        #Lazy Loading
		#subl3 /usr/bin/virtualenvwrapper.sh
		export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh #/usr/bin/virtualenvwrapper.sh
		
		if [ -e "/usr/bin/virtualenvwrapper_lazy.sh" ];then
			#reload the startup file
			source /usr/bin/virtualenvwrapper_lazy.sh

		elif [ -e "/usr/local/bin/virtualenvwrapper_lazy.sh" ];then
			source /usr/local/bin/virtualenvwrapper_lazy.sh

		else
			source /usr/bin/virtualenvwrapper.sh
		fi

	else
		show_msn_w "No"
    fi

	show_msn_w "-----------------Install some package on virtualenv -----------"

	#echo 'pip install sphinx' >> $WORKON_HOME/postmkvirtualenv
    #mkvirtualenv $NAME_PROYECT
    #http://virtualenvwrapper.readthedocs.org/en/latest/command_ref.html
    #mkvirtualenv [-a project_path] [-i package] [-r requirements_file] [virtualenv options] ENVNAME

    if [ -d $NAME_PROYECT ]; then
    	# associate an existing project directory with the new environment.

    	#or backup
		
		if [ -f "$PATH_PY_REQUERIMENTS" ];then
			#specify a text file listing packages to be installed
			show_msn_w "Build on exist project"
			mkvirtualenv -a $NAME_PROYECT -r $PATH_PY_REQUERIMENTS tests
			#like pip install -r requirements.txt
		else
			show_msn_w "Build on exist project with requirements manual"
			#mkvirtualenv -a $NAME_PROYECT
			mkvirtualenv tests
		fi

	else

		if [ -f "$PATH_PY_REQUERIMENTS" ];then
			#specify a text file listing packages to be installed
			show_msn_w "Build on new project"
			mkvirtualenv -r $PATH_PY_REQUERIMENTS tests 
		
		else
			#install one or more packages after the environment is created.
			show_msn_w "Build on exist project with -i"
			mkvirtualenv tests -i 
		fi
	fi

	exit 0

	# mkvirtualenv --no-site-packages --distribute test_django
	#mkvirtualenv -p python2 test
    workon tests

    show_msn_w "----------------------------"
	echo $VIRTUAL_ENV
	show_msn_w "----------------------------"
	pip install sphinx
	show_msn_w "----------------------------"
	lssitepackages
	show_msn_w "----------------------------"
	pip list
	show_msn_w "----------------------------"
	workon
	show_msn_w "----------------------------"
	#plseas look http://virtualenvwrapper.readthedocs.org/en/latest/projects.html#project-management

	#Automatically Run a Command after Environment Creation
	#echo '[bash-command]' >> $WORKON_HOME/postactivate

	#For Instance to Automatically Change to the New Env Directory:
	#echo 'cd $VIRTUAL_ENV' >> $WORKON_HOME/postactivate

	#To Automatically Installing Commonly Used Tools
	#echo 'pip install [myGoodTool]' >> $WORKON_HOME/postmkvirtualenv
	#echo 'pip install sphinx' >> $WORKON_HOME/postmkvirtualenv

    show_msn_w "--------------------FINISH -----------No"

	#stop working on it with:
	deactivate
    exit 0
    #echo 'pip install yolk' >> $WORKON_HOME/

    #if [ ! -f "/usr/bin/virtualenvwrapper.sh" ];then
    #if [ -z "$1" ] 


	

	# VIRTUAL_ENV=$HOME/.virtualenv

	# # Prepare isolated environment
	# virtualenv $VIRTUAL_ENV

	# # Activate isolated environment
	# source $VIRTUAL_ENV/bin/activate

	# # Install package
	# pip install -U socketIO-client

	export WORKON_HOME=$NAME_PROYECT
	mkdir -p $WORKON_HOME
	source /usr/bin/virtualenvwrapper.sh
	mkvirtualenv $NAME_PROYECT

	echo 'pip install yolk' >> $WORKON_HOME/

	echo 'pip install sphinx' >> $WORKON_HOME/postmkvirtualenv
#which sphinx-build
# mkvirtualenv env2
#workon env1
#echo $VIRTUAL_ENV



}

run_virtualenv()
{

VIRTUAL_ENV="$NAME_PROYECT"
export VIRTUAL_ENV

_OLD_VIRTUAL_PATH="$PATH"
PATH="$VIRTUAL_ENV/bin:$PATH"
export PATH

virtualenv2 --no-site-packages $NAME_PROYECT --verbose
source $NAME_PROYECT/bin/activate  # on unix

#source $NAME_PROYECT/scripts/activate     # on Windows
}

#Choose 
if search_python_pkgs virtualenvwrapper; then
    show_msn_w "Build env with virtualenvwrapper"
    run_virtualenvwrapper

elif search_python_pkgs virtualenv; then

	show_msn_w "Build env with virtualenv2"
	run_virtualenv
fi	
#pip install virtualenvwrapper

#search_python_pkgs virtualenv2

#install on arch linux
#pacman -Sy python2-pip python2-virtualenv

#ubuntu
#sudo su -c "apt-get install virtualenvwrapper"

#easy_install install pip

#you can  use alias like
#echo 'alias pip="/usr/bin/pip2"' >> $HOME/.bashrc
exit 0





exit 0
check_dependences()
{

	for dep in $DEPENDENCIES
        do
            if ! which $dep &>/dev/null;  then
                        DEPS_ALT="NO"
                        echo "============================================================";
                        echo "***** /bin/ This script requires $dep to run but it is not installed";
                        echo "============================================================";
                        
                        #echo "Try to install dependences";
            fi

        done

    show_msn_w $PYTHON_SITE_PKG

    #for easy search i use https://github.com/cakebread/yolk
    #sudo pip2 install yolk
    # yolk -l | grep "wxPython"

	for dep in $DEPENDENCIES_PIP
        do
             if ! which $dep &>/dev/null;  then
                        DEPS_PIP="NO"
                        echo "============================================================";
                        echo "***** PIP:: This script requires $dep to run but it is not installed";
                        echo "============================================================";
                        
                        #echo "Try to install dependences";
             fi

        done    

}

install_with_deb()
{
	check_package_manager
	su -c "$INSTALL_DEB $1"

}

install_with_package_manager()
{
	check_package_manager
	echo -e "$WHITE Please wait, exec command; $BLUE $PACKAGE_MANAGER $PKG_WPS $RESET"

	show_msn_w "Please wait -- $PACKAGE_MANAGER $PKG_WPS"
	show_msn_w "Please wait -- $PACKAGE_MANAGER $1"

	show_msn_w "$YELLOW Plase your password for install $1: $RESET"
	su -c "$PACKAGE_MANAGER $1" &>/dev/null #on arch error like if fail hide with &>/dev/null

	if test $? -eq 0; then
    	show_msn_w "Package $1 installed"
    	return 0  #if installed retiurn 0     	
    else
    	#for example if package not exist on pacman or packer liek Package `ax' does not exist.
    	show_msn_w "$LINENO: Error when try install with $PACKAGE_MANAGER the package $1"
    	return 1 #if not install
    	
  	fi

}  	

install_dependences()
{

	for dep in $DEPENDENCIES
        do
             if ! which $dep &>/dev/null;  then                        
                        show_msn_w "============================================================";
                        show_msn_w "***** Try to install $dep, please wait ..";
                        show_msn_w "============================================================";

                        install_with_package_manager $dep

                        if test $? -eq 0; then
    						show_msn_w "Success installed dependence: $1"				
    						return 0 #package installed without error
    					else
							show_msn_w "$LINENO --  ERROR no installd dependence: $1"
    						return 1
  						fi

                        #exit 0

                        #if [ ! $( install_with_package_manager $dep) ]; then
                        # 	show_msn_w "I can install dependences, please wait"                        
                        # 	return 0
                        # else
                        # 	show_msn_w "Todo bien"
                        # 	return 1
                        # fi

             fi

        done

}

check_dependences
#report_bug

#Testing all dependences 
show_msn_w "============================================================";
show_msn_w "\n Please wait, checking dependences .. \n"
show_msn_w "============================================================";

if [ "$DEPS_PIP" == "NO" ]; then
	echo -e "$RED The operative system missing dependencies for the following libraries ... $RESET"	
fi	

if [ "$DEPS_ALT" == "NO" ]; then

	echo -e "$RED The operative system missing dependencies for the following libraries ... $RESET"

	read -p "Do you wish to install dependences? [Yes (y) / No (n)]" choice
	case "$choice" in 
	  y|Y ) echo "yes"


            install_dependences

            if test $? -eq 0; then
            	#package installed without error
            	show_msn_w "$GREEN #############Dependences it's OK ############# $RESET"				            	
    		else
    			show_msn_w "$LINENO -- ERROR $RED I can't continue without dependences: $DEPENDENCIES $RESET"    			
    		fi

			# if install_dependences; then
			# 	echo "complete install"
			# else
			# 	show_msn_w "I can't install dependences"
			# fi

			;;
	  n|N ) exit 0
		
		;;
	  * ) echo "$RED invalid or you dont' have a tty or you are test the script on your source code editor $RESET";
	esac
fi

show_msn_w "$GREEN installation completed $RESET"

show_msn_w "#######################$RED IMPORTANT $RESET #######################"
show_msn_w "#####  This bash script use virtualenv:								"	
show_msn_w "#####                                              			   		"
show_msn_w "#####  On your terminal                                        		"
show_msn_w "#####  1. [$USER@$HOSTNAME erpmtics_socketio]$ cd $HOME			    "
show_msn_w "#######################$RED IMPORTANT $RESET #######################"

exit 0

#Testing use lib
#https://github.com/liris/websocket-client

#Lets got to Install (You should build a virtualenv because this lib cause conflic with 
# websockets provided by python by default)

#variables
THIS_SCRIPT_PATH=`readlink -f $0`
THIS_SCRIPT_DIR=`dirname ${THIS_SCRIPT_PATH}`

WINE_TARBALL=${THIS_SCRIPT_DIR}/wine.tar.gz

#Check permission
  sudo chown $USER -R ${THIS_SCRIPT_DIR}/build/
  sudo chown $USER -R ${THIS_SCRIPT_DIR}/dist/

  sudo chmod 775 -R ${THIS_SCRIPT_DIR}/build/
  sudo chmod 775 -R ${THIS_SCRIPT_DIR}/dist/


#python2 -c "import site; print(site.getsitepackages())"

#ls $site_packages

exit 0
if [ -n "$1" ]; then

	echo "Usage: update-erpmtics <version>"
  	# mkdir tmp
  	# curl https://raw.github.com/erpmtics/master/$1/erpmtics-desktop.zip -o tmp/erpmtics-desktop.zip
  	# rm -fr app/vendor/erpmtics
  	# unzip tmp/erpmtics.zip -d app/vendor
  	# mv app/vendor/erpmtics-$1 app/vendor/erpmtics
  	# rm -fr app/vendor/erpmtics/docs
else
	echo "n"
fi


if [ -d $srcdir/$_gitname virtualenv ]; then
	#statements
	echo -e "ok"
fi

exit 0
mkdir -p virtualenv

VIRTUAL_ENV=$HOME/.virtualenv

# Prepare isolated environment
virtualenv $VIRTUAL_ENV

# Activate isolated environment
source $VIRTUAL_ENV/bin/activate

# Install package
pip install -U socketIO-client

echo 'pip install sphinx' >> $WORKON_HOME/postmkvirtualenv
#which sphinx-build
# mkvirtualenv env2
#workon env1
#echo $VIRTUAL_ENV

#Lazy Loading
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh
