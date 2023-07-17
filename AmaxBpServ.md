
# 安装超级节点

### 服务器硬件要求

```
推荐使用 Ubuntu 18.04 LTS 或更高 Ubuntu 20.04 LTS、Ubuntu 22.04 LTS 版本

最低配置

CPU: 8 cores 8核或更高
RAM: 64GB 内存
NET: 10Mbps 10M带宽或更高
Storage Disk Space: SSD 500G 硬盘或更大
```

### 超级节点部署安装

1. 克隆下载 amax.dockers 文件

1.1 安装git
```
apt install -y git
```
1.2 进入home目录
```
cd ~
```

1.3 下载 amax.dockers 脚本
```
git clone https://github.com/armoniax/amax.dockers
```

2. 执行安装脚本

2.1 进入amax.meta.chain目录
```
cd ~/amax.dockers/amax.meta.chain
```

2.2 运行环境必要软件安装
```
bash ./step1_env_init.sh
```

![image](https://github.com/hub500/amax.dockers/assets/80018598/65d339fa-94ee-48f7-9587-52d8c991432b)


2.3 安装amax docker镜像
```
bash ./step2_amax_docker_setup.sh
```

![image](https://github.com/hub500/amax.dockers/assets/80018598/7e644913-d038-4317-88e9-7e999af65e36)

![image](https://github.com/hub500/amax.dockers/assets/80018598/5cd311a4-2714-4a91-98fd-73dc637e6f38)


2.4 查看amnod日志
```
bash ./step3_logs.sh
```

3. 修改节点配置信息

进入 .amax_mainnet_0.5.2 目录
```
cd ~/.amax_mainnet_0.5.2/conf
```

* 修改 ~/.amax_mainnet_0.5.2/conf/node.ini p2p地址

```
vi ~/.amax_mainnet_0.5.2/conf/node.ini
```

修改以下内容
```
p2p-server-address = $me:9806 # modify it to external IP or domain

p2p-peer-address = $peer:9806 # modify it to external IP or domain
```
替换 p2p-server-address 信息

> p2p-server-address = 当前服务器公网IP:9806

替换 p2p-peer-address 信息

> p2p-peer-address = exp2.nchain.me:9806

![image](https://github.com/hub500/amax.dockers/assets/80018598/0b4cd996-1d1b-4476-b0f5-ee0fc3143b2b)


### 修改配置节点私钥

* 修改 ~/.amax_mainnet_0.5.2/conf/plugin_bp.ini 节点账号及公私钥

```
vi ~/.amax_mainnet_0.5.2/conf/plugin_bp.ini
```

修改以下内容
```
# ID of producer controlled by this node (e.g. inita; may specify multiple times) (eosio::producer_plugin)
producer-name = $producer_name # to be udpated with actual producer name
# Key=Value pairs in the form <public-key>=<provider-spec>
signature-provider = AM5SMw8Lum7MG9V61LQz8enJyM9MB7WBpvoiXsp5YmAJXZmE92j2=KEY:5J9brwX39nYZnDBLXYQPc2BgiXJ12HxeapKvTo15wRh1et7RhVW #replace it to the actual value
```

请替换 节点账号 producer_name: 参与超级节点投票的候选人账号

请替换 节点公私钥 signature-provider: 参与超级节点投票时填写的公钥地址(默认为账号的公私钥, 可以自行更换)

![image](https://github.com/hub500/amax.dockers/assets/80018598/41c31738-c431-4701-94f9-059f05913024)

![image](https://github.com/hub500/amax.dockers/assets/80018598/3aa981cb-bab9-4533-9e35-444520a81066)


### 重启超级节点

1. 查看镜像名称

```
docker ps
```
会显示列出 amnod-mainnet-0.5.2 名称

![image](https://github.com/hub500/amax.dockers/assets/80018598/74604245-2659-4ba1-81a1-b08facc98512)


2. 重启节点

```
docker restart amnod-mainnet-0.5.2
```

![image](https://github.com/hub500/amax.dockers/assets/80018598/641a4d88-21d8-49d8-816e-b99359485528)


### 查询节点状态, 日志查看等

1. 查看BP节点日志
```
tail -f /opt/data/amax_mainnet_0.5.2/logs/amnod.log
或
docker logs amnod-mainnet-0.5.2
```

![image](https://github.com/hub500/amax.dockers/assets/80018598/9310d2fd-cbca-47e2-9154-8812e8d5d8b6)


2. 查看BP节点运行状态
```
docker exec -it amnod-mainnet-0.5.2 amcli get info
```

![image](https://github.com/hub500/amax.dockers/assets/80018598/5a8f8996-d151-460e-b877-031188388992)

