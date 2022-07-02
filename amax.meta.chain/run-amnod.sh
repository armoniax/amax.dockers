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
    
set -a && source $CONF_DIR/amnod.env

DEST_HOME="${NODE_HOME}/amax_${NET}"
DEST_CONF="${DEST_HOME}/conf/config.ini"
mkdir -p $DEST_HOME/conf $DEST_HOME/data $DEST_HOME/logs

cd $CONF_DIR
cp -r   ./bin                   $DEST_HOME/         && \
cp      ./genesis.json          $DEST_HOME/conf/    && \
cp      ./conf/conf_base.ini    $DEST_CONF

# copy conf node info into config
echo " " >> $DEST_CONF
echo "#### Node base conf: " >> $DEST_CONF
cat ./conf/conf_node.ini >> $DEST_CONF

if  [ "${history_plugin}" == "true" ]; then
    echo " " >> $DEST_CONF
    echo "#### History plugin conf: " >> $DEST_CONF
    cat ./conf/conf_plugin_history.ini >> $DEST_CONF
fi

if  [ "${state_plugin}" == "true" ]; then
    echo " " >> $DEST_CONF
    echo "#### State plugin conf: " >> $DEST_CONF
    cat ./conf/conf_plugin_state.ini >> $DEST_CONF
fi

if  [ "${bp_plugin}" == "true" ]; then
    echo " " >> $DEST_CONF
    echo "#### Block producer plugin conf: " >> $DEST_CONF
    cat ./conf/conf_plugin_bp.ini >> $DEST_CONF
fi

docker-compose --env-file ./amnod.env up -d
#podman-compose --env-file ./amnod.env up -d

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