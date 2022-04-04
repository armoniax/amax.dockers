NET=$1
[ -z "$NET" ] && svc=testnet

HOME_DIR=/opt/data/amax_$NET
mkdir -p $HOME_DIR
cd $HOME_DIR && mkdir -p data logs

svc=amond-$NET
podman-compose up $svc --build -d 