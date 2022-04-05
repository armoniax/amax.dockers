#!/bin/bash

node=$1
param=$2

AMAX=/opt/data/amax_mainnet
CONDIR=$AMAX/conf
DATDIR=$AMAX/data
LOGDIR=$AMAX/logs
LOGFILE=$LOGDIR/amnod.log

ulimit -c unlimited
ulimit -n 65535
ulimit -s 64000

TIMESTAMP=$(/bin/date +%s)
NEW_LOG="amnod-$TIMESTAMP.log"
NEW_LOGFILE=$AMAX/logs/$NEW_LOG
NEWLOG=$LOGDIR/$NEW_LOG

touch $NEW_LOGFILE

OPTIONS="--data-dir $DATDIR --config-dir $CONDIR"
[[ ! -f ${DATDIR}/blocks/blocks.index ]] && OPTIONS="$OPTIONS --genesis-json $CONDIR/genesis.json"

trap 'echo "[$(date)]Start Shutdown"; kill $(jobs -p); wait; echo "[$(date)]Shutdown ok"' SIGINT SIGTERM

## launch amnod program...
amnod $param $OPTIONS -e --disable-replay-opts >> $NEWLOG 2>&1 &
#amnod  $param $OPTIONS --delete-all-blocks >> $NEWLOG 2>&1 &
#amnod  $param $OPTIONS --hard-replay-blockchain --truncate-at-block 87380000 >> $NEWLOG 2>&1 &
echo $! > $AMAX/amnod.pid


[[ -f "$LOGFILE" ]] && unlink $LOGFILE
ln -s $NEW_LOGFILE $LOGFILE

# tail -f /dev/null
wait