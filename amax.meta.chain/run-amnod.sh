NET=$1

CONF_DIR=~/.amax_$NET
mkdir -p $CONF_DIR
ls -la $CONF_DIR
[ ! -f $CONF_DIR/amnod.conf ] && \
    cp ./amnod/$NET/amnod.env $CONF_DIR/ && \
    cp -r ./amnod/conf $CONF_DIR/ && \
    cp -r ./amnod/bin $CONF_DIR/ && \
    cp ./amnod/$NET/genesis.json $CONF_DIR/

set -a && source $CONF_DIR/amnod.env

DEST_HOME="${NODE_HOME}/amax_${NET}"
DEST_CONF="${DEST_HOME}/conf/config.ini"
mkdir -p $DEST_HOME/conf $DEST_HOME/data $DEST_HOME/logs

cp -r   $CONF_DIR/bin                   $DEST_HOME/         && \
cp      $CONF_DIR/genesis.json          $DEST_HOME/conf/    && \
cp      $CONF_DIR/conf/conf_base.ini    $DEST_CONF

# copy conf node info into config
echo " " >> $DEST_CONF
echo "#### Node base conf: " >> $DEST_CONF
cat $CONF_DIR/conf/conf_node.ini >> $DEST_CONF

if  [ "${history_plugin}" == "true" ]; then
    echo " " >> $DEST_CONF
    echo "#### History plugin conf: " >> $DEST_CONF
    cat $CONF_DIR/conf/conf_plugin_history.ini >> $DEST_CONF
fi

if  [ "${state_plugin}" == "true" ]; then
    echo " " >> $DEST_CONF
    echo "#### State plugin conf: " >> $DEST_CONF
    cat $CONF_DIR/conf/conf_plugin_state.ini >> $DEST_CONF
fi

if  [ "${bp_plugin}" == "true" ]; then
    echo " " >> $DEST_CONF
    echo "#### Block producer plugin conf: " >> $DEST_CONF
    cat $CONF_DIR/conf/conf_plugin_bp.ini >> $DEST_CONF
fi

cd $NET && docker-compose up -d
#cd $NET && podman-compose up -d

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