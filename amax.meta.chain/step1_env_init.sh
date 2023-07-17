
# 系统运行环境 软件包安装

# 系统更新
apt update
apt upgrade -y
apt install -y curl dpkg apt-transport-https ca-certificates

# 添加docker源
curl -sSL https://download.docker.com/linux/debian/gpg | gpg --dearmor > /usr/share/keyrings/docker-ce.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-ce.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -sc) stable" > /etc/apt/sources.list.d/docker.list

# 安装docker
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

docker version
docker compose version

# 安装docker-compose
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

docker-compose version

# 重启docker
systemctl restart docker
