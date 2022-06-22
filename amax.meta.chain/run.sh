NET=$1
[ -z "$NET" ] && NET=devnet

cd $NET
set -a
source ./.env

NOD_DIR=/opt/data/amax_$NET
mkdir -p $NOD_DIR $NOD_DIR/data $NOD_DIR/logs

cp -r ../bin  $NOD_DIR/
cp -r ./conf $NOD_DIR/

#podman-compose up -d
docker-compose up -d

if   [ "$NET" = "mainnet" ]; then
    sudo iptables -I INPUT -p tcp -m tcp --dport 9806 -j ACCEPT
    sudo iptables -I INPUT -p tcp -m tcp --dport 8888 -j ACCEPT
elif [ "$NET" = "testnet" ]; then
    sudo iptables -I INPUT -p tcp -m tcp --dport 19806 -j ACCEPT
    sudo iptables -I INPUT -p tcp -m tcp --dport 18888 -j ACCEPT
elif [ "$NET" = "devnet" ]; then
    sudo iptables -I INPUT -p tcp -m tcp --dport 29806 -j ACCEPT
    sudo iptables -I INPUT -p tcp -m tcp --dport 28888 -j ACCEPT
fi