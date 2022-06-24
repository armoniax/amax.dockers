#!/bin/bash

NODE_HOME=$1
net=$2
param=$3

AMAX="${NODE_HOME}/amax_$net"
LOGFILE=$AMAX/logs/amnod.log

ulimit -c unlimited
ulimit -n 65535
ulimit -s 64000

TIMESTAMP=$(/bin/date +%s)
NEW_LOGFILE="${AMAX}/logs/amnod-${TIMESTAMP}.log"

touch $NEW_LOGFILE

OPTIONS="--data-dir $AMAX/data --config-dir $AMAX/conf"
[[ ! -f $AMAX/data/blocks/blocks.index ]] && OPTIONS="$OPTIONS --genesis-json $AMAX/conf/genesis.json"

trap 'echo "[$(date)]Start Shutdown"; kill $(jobs -p); wait; echo "[$(date)]Shutdown ok"' SIGINT SIGTERM

## launch amnod program...
amnod $param $OPTIONS >> $NEW_LOGFILE 2>&1 &
#amnod  $param $OPTIONS --delete-all-blocks >> $NEW_LOGFILE 2>&1 &
#amnod  $param $OPTIONS --hard-replay-blockchain --truncate-at-block 87380000 >> $NEW_LOGFILE 2>&1 &
echo $! > $AMAX/amnod.pid


[[ -f "$LOGFILE" ]] && unlink $LOGFILE
ln -s $NEW_LOGFILE $LOGFILE

# tail -f /dev/null
wait