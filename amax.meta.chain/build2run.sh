NET=$1
[ -z "$NET" ] && svc=testnet

HOME_DIR=/opt/data/amax_$NET
mkdir -p $HOME_DIR $HOME_DIR/data $HOME_DIR/logs

svc=amond-$NET
podman-compose up $svc --build -d