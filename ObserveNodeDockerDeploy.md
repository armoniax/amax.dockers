### 一、准备启动脚本 
```git clone https://github.com/armoniax/amax.dockers.git```
  
```cd amax.dockers/amax.meta.chain```
  
```sh setup-amnod.sh mainnet 001```

打印出一个目录/xxx/.amax_mainnet_001 (先记住这个路径，后面用到)


### 二、准备区块数据快照

```cd /opt/data```

```mkdir -p amax_mainnet_001/data/snapshots/```

```cd amax_mainnet_001/data/snapshots/```


打开 https://snapshot.amaxscan.io/ , 复制文件链接.


下载、解压文件(安装解压工具：```yum install zstd```)

```wget https://snapshot.amaxscan.io/snapshot-03c7xx.bin.zst```

```unzstd snapshot.amaxscan.io/snapshot-03c7xx.bin.zst```



### 三、启动docker 容器

进入第一步生成的文件夹

```cd /home/devops/.amax_mainnet_001```

```vim bin/start.sh```

找到./data/snapshots/snapshot-03c75e09723daf6e18a716a37934059c68aa5f00de0b89a1a277f6ab36b08294.bin

更新snapshot文件名

运行启动命令

```sh run.sh```

即可启动容器amnod-mainnet-001

### 四、检查容器状态

进入容器

```docker exec -it amnod-mainnet-001 bash```

检查节点状态

```amcli get info```

（需要5-10分钟时间同步快照数据）

