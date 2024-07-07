---

# Code-Server 工作空间 Docker 镜像

此 Docker 镜像结合了 `code-server` 和 `gitpod/workspace-full` 镜像，提供一个随时可用的、功能完备的 VSCode 开发环境。

## 特点
- 预装了基本开发工具和扩展
- 可随时使用的 VSCode 服务器
- 易于扩展以满足特定需求

## 使用方法
使用以下命令启动一个容器：

```bash
docker run -d -p 8443:8443 -v /path/to/config:/config carry00/code-server-workspace:latest
```

- `-p 8443:8443`：将容器的 8443 端口映射到主机。
- `-v /path/to/config:/config`：将主机目录挂载到容器以持久化配置。

## 环境变量
- `USER`：VSCode 服务器的用户（默认：`gitpod`）。
- `HOME`：用户的主目录（默认：`/home/gitpod`）。

## 示例
启动一个新容器：

```bash
docker run -d -p 8443:8443 -v $(pwd)/config:/config carry00/code-server-workspace:latest
```

然后，打开浏览器并导航到 `http://localhost:8443` 开始编码。

## 使用案例

### Docker Compose (推荐)
```yaml
version: '3.3'

services:
  code-server:
    image: carry00/code-server-workspace:latest
    container_name: code-server
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - PASSWORD=password # 可选
      - HASHED_PASSWORD= # 可选
      - SUDO_PASSWORD=password # 可选
      - SUDO_PASSWORD_HASH= # 可选
      - PROXY_DOMAIN=code-server.my.domain # 可选
      - DEFAULT_WORKSPACE=/config/workspace # 可选
    volumes:
      - /path/to/appdata/config:/config
    ports:
      - 8443:8443
    restart: unless-stopped
```

### Docker CLI
```bash
docker run -d \
  --name=code-server \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e PASSWORD=password `# 可选` \
  -e HASHED_PASSWORD= `# 可选` \
  -e SUDO_PASSWORD=password `# 可选` \
  -e SUDO_PASSWORD_HASH= `# 可选` \
  -e PROXY_DOMAIN=code-server.my.domain `# 可选` \
  -e DEFAULT_WORKSPACE=/config/workspace `# 可选` \
  -p 8443:8443 \
  -v /path/to/appdata/config:/config \
  --restart unless-stopped \
  carry00/code-server-workspace:latest
```

## 自定义
您可以根据需要自定义 Dockerfile 以包含其他工具和设置。

## 许可证
此项目采用 MIT 许可证。

---

以下是一个用于 `carry00/code-server-workspace` 镜像的 README 文件示例：

---

# Code-Server Workspace Docker Image

This Docker image provides a ready-to-use, fully-fledged development environment with VSCode, built on top of the `gitpod/workspace-base` image.

## Features
- Pre-installed with essential development tools
- Ready-to-use VSCode server
- Easily extendable for specific needs

## Usage
To start a container with this image, use the following command:

```bash
docker run -d -p 8443:8443 -v /path/to/config:/config carry00/code-server-workspace:latest
```

- `-p 8443:8443`: Maps port 8443 from the container to your host.
- `-v /path/to/config:/config`: Mounts a directory from your host to the container for persistent configuration.

## Environment Variables
- `USER`: The user for the VSCode server (default: `gitpod`).
- `HOME`: Home directory for the user (default: `/home/gitpod`).

## Example
Start a new container:

```bash
docker run -d -p 8443:8443 -v $(pwd)/config:/config carry00/code-server-workspace:latest
```

Then, open your browser and navigate to `http://localhost:8443` to start coding.

## Customization
You can customize the Dockerfile to include additional tools and settings as needed.

## License
This project is licensed under the MIT License.

---

