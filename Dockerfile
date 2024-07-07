# 使用 gitpod/workspace-full:latest 作为基础镜像
FROM gitpod/workspace-full:latest

# 设置环境变量
ENV DEBIAN_FRONTEND="noninteractive" \
    USER=gitpod \
    HOME=/home/gitpod \
    CODE_RELEASE=latest

# 安装运行时依赖
RUN sudo apt-get update && \
    sudo apt-get install -y \
    git \
    jq \
    libatomic1 \
    nano \
    net-tools \
    netcat \
    sudo && \
    sudo apt-get clean 
# 下载并安装 Code-Server
RUN sudo mkdir -p /app/code-server && \
    cd /app/code-server && \
    sudo curl -fL https://github.com/cdr/code-server/releases/download/${CODE_RELEASE}/code-server-${CODE_RELEASE}-linux-amd64.tar.gz -o code-server.tar.gz && \
    sudo tar -xzf code-server.tar.gz --strip-components=1 && \
    sudo rm code-server.tar.gz && \
    sudo ln -s /app/code-server/bin/code-server /usr/local/bin/code-server

# 暴露端口和卷
EXPOSE 8443
VOLUME /config

# 启动 Code-Server
CMD ["sudo", "code-server", "--bind-addr", "0.0.0.0:8443", "--auth", "none", "/config"]
