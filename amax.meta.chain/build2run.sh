NET=$1
[ -z "$NET" ] && NET=testnet

SRC_DIR=./env_$NET
NOD_DIR=/opt/data/amax_$NET
mkdir -p $NOD_DIR $NOD_DIR/data $NOD_DIR/logs
cp -r ${SRC_DIR}/bin  $NOD_DIR/
cp -r ${SRC_DIR}/conf $NOD_DIR/

podman-compose -f ${SRC_DIR}/docker-compose.yml up --build -d