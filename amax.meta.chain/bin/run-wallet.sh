#！/bin/bash

NODE_HOME=$1

WALLDIR=$NODE_HOME/amax_wallet
DATDIR=$WALLDIR/data
CONFDIR=$WALLDIR/conf
LOGDIR=$WALLDIR/logs

mkdir -p $DATDIR $CONFDIR $LOGDIR

TIMESTAMP=$(/bin/date +%s)
NEW_LOG="amax-wal-$TIMESTAMP.log"

#apt update && apt install -y libusb-1.0-0

amkey --config-dir $CONFDIR -d $DATDIR --unix-socket-path $DATDIR/amkey.sock >> $LOGDIR/$NEW_LOG 2>&1 &

echo $! > $DATDIR/wallet.pid
unlink $LOGDIR/amax-wal.log
ln -s $LOGDIR/$NEW_LOG $LOGDIR/amax-wal.log
tail -f /dev/null