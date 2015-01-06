#!/bin/bash

# should be run in libs/

# install arc libs
LIBS_DIR=$PWD
ARC_DIR=$LIBS_DIR/arc

if [[ ! -e $ARC_DIR ]]; then
    echo 'installing arc ...'
    mkdir $ARC_DIR
    cd $ARC_DIR
    git clone https://github.com/phacility/libphutil.git
    git clone https://github.com/phacility/arcanist.git
    cd $LIBS_DIR
else
   echo 'arc already installed; skipping...'
fi

PIP_PATH=`which pip`
if [[ ! -f $PIP_PATH ]]; then
    echo 'please run "sudo easy_install pip" to continue...'
fi

VIRTUAL_ENV_PATH=`which virtualenvwrapper_lazy.sh`
if [[ ! -f $VIRTUAL_ENV_PATH ]]; then
    echo 'please run "pip install virtualenvwrapper" to continue...'
fi
