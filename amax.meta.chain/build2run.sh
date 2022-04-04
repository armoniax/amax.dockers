NET=$1
[ -z "$NET" ] && NET=testnet

SRC_DIR=env_$NET
HOME_DIR=/opt/data/amax_$NET
mkdir -p $HOME_DIR $HOME_DIR/data $HOME_DIR/logs
cp -r ./${SRC_DIR}/bin  $HOME_DIR/
cp -r ./${SRC_DIR}/conf $HOME_DIR/

podman-compose -f ./${SRC_DIR}/docker-compose.yml up --build -d