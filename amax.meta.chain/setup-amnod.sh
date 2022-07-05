NET=$1
tag=$2

CONF_DIR=~/.amax_${NET}_${tag}
mkdir -p $CONF_DIR

[ ! -f "$CONF_DIR/amnod.env" ]                          && \
    cp      ./amnod/$NET/amnod.env      $CONF_DIR/      && \
    cp      ./amnod/$NET/genesis.json   $CONF_DIR/      && \
    cp      ./amnod/docker-compose.yml  $CONF_DIR/      && \
    cp -r   ./amnod/conf                $CONF_DIR/      && \
    cp -r   ./amnod/bin                 $CONF_DIR/
    
echo "NET=$NET" >> $CONF_DIR/amnod.env
echo "tag=$tag" >> $CONF_DIR/amnod.env
set -a && source $CONF_DIR/amnod.env

DEST_HOME="${NODE_HOME}/amax_${NET}"
DEST_CONF="${DEST_HOME}/conf/config.ini"
mkdir -p $DEST_HOME/conf $DEST_HOME/data $DEST_HOME/logs
cp ./run-amnod.sh $CONF_DIR/run.sh
chmod +x $CONF_DIR/run.sh