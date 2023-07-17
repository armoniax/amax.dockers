
# BP节点配置

config.ini 是由nodeos生成的默认配置文件，搭建 producer1234 账户的BP节点最少需要修改以下配置：

```
// BP账户名
producer-name = producer1234
// signature-provider的格式为${public_key}=KEY:${private_key}
signature-provider = EOS7PD3ykQtKAgkkYb4jrG5fpgZa4RPTUmyq8r31eNdgxwMjUx7sR=KEY:5Kg8jkyxSZ7GSAYGUJ42PugigxEKHpxEaRiWsSu8tgfUb98yxf9

// 必要插件
plugin = eosio::chain_plugin
plugin = eosio::chain_api_plugin
plugin = eosio::producer_plugin
plugin = eosio::http_plugin

// 可选支持钱包操作
// plugin = eosio::wallet_plugin
// plugin = eosio::wallet_api_plugin

// 若不希望暴露RPC端口给网外，修改为127.0.0.1:8888
http-server-address = 0.0.0.0:8888

// 可以添加多个，但是你用到的时候可能已经失效，若没有一个能用的通信节点，可在网络上查找
p2p-peer-address = bp.cryptolions.io:9876
p2p-peer-address = p2p.mainnet.eospace.io:88
```

# 查看BP节点

```
// 查看BP节点日志
docker logs amnod-mainnet-0.5.2

// 查看BP节点运行状态
docker exec -it amnod-mainnet-0.5.2 amcli get info
```
