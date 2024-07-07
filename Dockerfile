# 使用 gitpod/workspace-full:latest 作为基础镜像
FROM gitpod/workspace-full:latest

# 设置环境变量
ENV DEBIAN_FRONTEND="noninteractive" \
    CODE_RELEASE=latest

# 切换到 root 用户
USER root

# 更新包列表并安装依赖
RUN apt-get update && \
    apt-get install -y \
    git \
    jq \
    libatomic1 \
    nano \
    net-tools \
    netcat && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 下载并安装 Code-Server
RUN mkdir -p /app/code-server && \
    cd /app/code-server && \
    curl -fL https://github.com/cdr/code-server/releases/download/${CODE_RELEASE}/code-server-${CODE_RELEASE}-linux-amd64.tar.gz -o code-server.tar.gz && \
    tar -xzf code-server.tar.gz --strip-components=1 && \
    rm code-server.tar.gz && \
    ln -s /app/code-server/bin/code-server /usr/local/bin/code-server

# 暴露端口和卷
EXPOSE 8443
VOLUME /config

# 启动 Code-Server
CMD ["code-server", "--bind-addr", "0.0.0.0:8443", "--auth", "none", "/config"]
