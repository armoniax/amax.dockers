#! /bin/bash

NODE_HOME=$1

WALLDIR=$NODE_HOME
DATDIR=$WALLDIR/data
CONFDIR=$WALLDIR/conf
LOGDIR=$WALLDIR/logs

TIMESTAMP=$(/bin/date +%s)
NEW_LOG="amax-wal-$TIMESTAMP.log"

#apt update && apt install -y libusb-1.0-0

amkey --config-dir ./conf -d ./data --unix-socket-path ./amkey.sock >> $LOGDIR/$NEW_LOG 2>&1 &

echo $! > $DATDIR/wallet.pid
unlink $LOGDIR/amax-wal.log
ln -s /opt/amax/logs/$NEW_LOG /opt/amax/logs/amax-wal.log
tail -f /dev/null
