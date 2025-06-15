# Docker 容器化笔记

## 📖 基础概念

Docker 是一个开源的容器化平台，可以帮助开发者打包应用及其依赖环境。

### 核心组件
- **镜像 (Image)**: 只读模板，包含应用运行所需的一切
- **容器 (Container)**: 镜像的运行实例
- **仓库 (Repository)**: 存储和分发镜像的地方
- **Dockerfile**: 构建镜像的脚本文件

## 🛠️ 常用命令

### 镜像管理
```bash
# 拉取镜像
docker pull nginx:latest

# 查看本地镜像
docker images

# 删除镜像
docker rmi image_id

# 构建镜像
docker build -t myapp:v1.0 .
```

### 容器操作
```bash
# 运行容器
docker run -d -p 80:80 --name mynginx nginx

# 查看运行中的容器
docker ps

# 查看所有容器
docker ps -a

# 停止容器
docker stop container_id

# 删除容器
docker rm container_id

# 进入容器
docker exec -it container_id /bin/bash
```

### 数据管理
```bash
# 创建数据卷
docker volume create myvolume

# 挂载数据卷
docker run -v myvolume:/data ubuntu

# 绑定挂载
docker run -v /host/path:/container/path ubuntu
```

## 📋 Docker Compose

### 基本配置文件
```yaml
version: '3.8'
services:
  web:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
    depends_on:
      - db
  
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: myapp
    volumes:
      - db_data:/var/lib/mysql

volumes:
  db_data:
```

### 常用操作
```bash
# 启动服务
docker-compose up -d

# 停止服务
docker-compose down

# 查看日志
docker-compose logs

# 重新构建
docker-compose build
```

## 🏗️ Dockerfile 最佳实践

### 基础模板
```dockerfile
# 使用官方基础镜像
FROM node:16-alpine

# 设置工作目录
WORKDIR /app

# 复制依赖文件
COPY package*.json ./

# 安装依赖
RUN npm ci --only=production

# 复制应用代码
COPY . .

# 暴露端口
EXPOSE 3000

# 创建非root用户
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
USER nextjs

# 启动命令
CMD ["npm", "start"]
```

### 优化技巧
- 使用 `.dockerignore` 排除不需要的文件
- 合并 RUN 指令减少镜像层数
- 使用多阶段构建减小镜像大小
- 将变化频繁的指令放在后面

## 🔧 实践案例

### 1. Web 应用部署
```yaml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    volumes:
      - ./logs:/app/logs
    restart: unless-stopped

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - app
```

### 2. 开发环境
```yaml
version: '3.8'
services:
  dev:
    build:
      context: .
      target: development
    volumes:
      - .:/app
      - /app/node_modules
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
    command: npm run dev
```

## 🚀 高级特性

### 网络配置
```bash
# 创建自定义网络
docker network create mynetwork

# 连接容器到网络
docker run --network mynetwork myapp
```

### 健康检查
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
```

### 多平台构建
```bash
# 构建多架构镜像
docker buildx build --platform linux/amd64,linux/arm64 -t myapp:latest .
```

## 📚 参考资源

- [Docker 官方文档](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Best Practices](https://docs.docker.com/develop/dev-best-practices/)

## 🐛 常见问题

### Q: 容器启动失败？
A: 检查端口是否被占用，查看容器日志 `docker logs container_id`

### Q: 镜像构建慢？
A: 使用 `.dockerignore`，优化 Dockerfile 层结构，使用本地缓存

### Q: 数据丢失？
A: 使用数据卷持久化重要数据，避免将数据存储在容器内部

---
*最后更新: $(date +%Y-%m-%d)*
