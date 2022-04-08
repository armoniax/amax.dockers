NET=$1
[ -z "$NET" ] && NET=testnet

SRC_DIR=./env_$NET
NOD_DIR=/opt/data/amax_$NET
mkdir -p $NOD_DIR $NOD_DIR/data $NOD_DIR/logs
cp -r ${SRC_DIR}/bin  $NOD_DIR/
cp -r ${SRC_DIR}/conf $NOD_DIR/

set -a
source ${SRC_DIR}/.env
podman-compose up -d

if [ "$NET" = "mainnet" ]; then
    sudo iptables -I INPUT -p tcp -m tcp --dport 9806 -j ACCEPT
    sudo iptables -I INPUT -p tcp -m tcp --dport 8888 -j ACCEPT
fi