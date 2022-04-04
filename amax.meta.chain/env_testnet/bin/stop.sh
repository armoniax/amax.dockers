#!/bin/bash

AMAX=/opt/amax
DATADIR=$AMAX/data
GENESIS=$AMAX/genesis.json

if [ -f $DATADIR"/amnod.pid" ]; then
    pid=$(cat $DATADIR"/amnod.pid")
    echo $pid
    kill $pid
    rm -r $DATADIR"/amnod.pid"

    echo -ne "Stopping amnod"

    while true; do
        [ ! -d "/proc/$pid/fd" ] && break
        echo -ne "."
        sleep 1
    done
    echo -ne "\ramnod stopped. \n"

fi