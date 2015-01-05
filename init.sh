#!/bin/bash

INIT_ROOT_DIR=${PWD}
LIBS_DIR="${PWD}/libs"

if [[ -e $LIBS_DIR ]]; then
    echo 'installing libs...'
    cd $LIBS_DIR
    sh "$LIBS_DIR/init.sh"
    cd $INIT_ROOT_DIR
else
    echo 'something went very wrong installing libs' 
fi
