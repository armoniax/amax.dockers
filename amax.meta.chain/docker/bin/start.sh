#!/bin/bash

node=$1
param=$2

AMAX=/opt/data/amax
CONDIR=$AMAX/conf
DATDIR=$AMAX/data
LOGDIR=$AMAX/logs
LOGFILE=$LOGDIR/amax.log

#sh $BINDIR/stop.sh $node || true
echo -e "Starting amnod for $node ...\n";

ulimit -c unlimited
ulimit -n 65535
ulimit -s 64000

TIMESTAMP=$(/bin/date +%s)
NEW_LOG="amax-$TIMESTAMP.log"
NEW_LOGFILE=$AMAX/logs/$NEW_LOG
touch $NEW_LOGFILE

amnod $param --genesis-json $CONDIR/genesis.json -e --data-dir $DATDIR --config-dir $CONDIR >> $LOGDIR/$NEW_LOG 2>&1 &

#amnod -e --data-dir $DATDIR --config-dir $CONDIR --delete-all-blocks --genesis-json $CONDIR/genesis.json  >> $LOGDIR/$NEW_LOG 2>&1 &
#amnod -e --data-dir $DATDIR --config-dir $CONDIR --hard-replay-blockchain --truncate-at-block 87380000 --genesis-json $CONDIR/genesis.json  >> $LOGDIR/$NEW_LOG 2>&1 &

echo $! > $AMAX/amnod.pid

[[ -f "$LOGFILE" ]] && unlink $LOGFILE
ln -s $NEW_LOGFILE $LOGFILE
tail -f /dev/null