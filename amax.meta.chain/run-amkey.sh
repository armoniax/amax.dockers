#！/bin/bash

cd amkey

set -a
source ./.env

NOD_DIR="${NODE_HOME}/amax_wallet"
mkdir -p $NOD_DIR/bin $NOD_DIR/conf $NOD_DIR/data $NOD_DIR/logs

cp ../bin/run-wallet.sh $NOD_DIR/bin/
cp ./config.ini $NOD_DIR/conf/
chmod +x $NOD_DIR/bin/wallet.sh

#podman-compose up -d
docker-compose up -d

sudo iptables -I INPUT -p tcp -m tcp --dport 7777 -j ACCEPT
