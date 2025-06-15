#!/bin/bash

# GitBook 知识库一键生成脚本
# 使用方法: ./setup-gitbook.sh [仓库名] [作者名] [邮箱]

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印彩色信息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 获取参数
REPO_NAME=${1:-"my-knowledge-base"}
AUTHOR_NAME=${2:-"Your Name"}
AUTHOR_EMAIL=${3:-"your-email@example.com"}

print_info "开始创建 GitBook 知识库: $REPO_NAME"
print_info "作者: $AUTHOR_NAME <$AUTHOR_EMAIL>"

# 创建主目录
mkdir -p "$REPO_NAME"
cd "$REPO_NAME"

# 创建目录结构
print_info "创建目录结构..."
mkdir -p docs/{tech,work,resources}
mkdir -p assets/{images,css}
mkdir -p .github/workflows

# 创建 _config.yml
print_info "生成 _config.yml..."
cat > _config.yml << EOF
title: ${REPO_NAME}
description: 个人学习和工作笔记整理
author: ${AUTHOR_NAME}
email: ${AUTHOR_EMAIL}

# 使用 gitbook 主题
remote_theme: sighingnow/jekyll-gitbook

# 插件
plugins:
  - jekyll-sitemap
  - jekyll-feed
  - jekyll-paginate

# GitBook 配置
gitbook:
  pdf_file: false
  download: false
  sharing:
    github: true
    edit: true
  
# 导航配置
toc:
  enabled: true
  h_min: 1
  h_max: 3

# 搜索功能
search:
  enabled: true

# 基本配置
baseurl: ""
url: "https://$(git config --global user.name || echo "username").github.io"

# Markdown 处理
markdown: kramdown
highlighter: rouge
kramdown:
  input: GFM
  syntax_highlighter: rouge

# 排除文件
exclude:
  - Gemfile
  - Gemfile.lock
  - node_modules
  - vendor/bundle/
  - vendor/cache/
  - vendor/gems/
  - vendor/ruby/
  - setup-gitbook.sh
EOF

# 创建 book.json
print_info "生成 book.json..."
cat > book.json << EOF
{
  "title": "${REPO_NAME}",
  "author": "${AUTHOR_NAME}",
  "description": "个人学习和工作笔记",
  "language": "zh-hans",
  "gitbook": "3.2.3",
  "structure": {
    "readme": "README.md",
    "summary": "SUMMARY.md"
  },
  "plugins": [
    "search-pro",
    "back-to-top-button",
    "expandable-chapters-small",
    "insert-logo",
    "github-buttons",
    "edit-link",
    "copy-code-button",
    "prism",
    "-highlight",
    "splitter",
    "sharing-plus",
    "tbfed-pagefooter"
  ],
  "pluginsConfig": {
    "insert-logo": {
      "url": "assets/images/logo.png",
      "style": "background: none; max-height: 30px;"
    },
    "github-buttons": {
      "buttons": [{
        "user": "$(git config --global user.name || echo "username")",
        "repo": "${REPO_NAME}",
        "type": "star",
        "size": "small",
        "count": true
      }]
    },
    "edit-link": {
      "base": "https://github.com/$(git config --global user.name || echo "username")/${REPO_NAME}/edit/main",
      "label": "编辑此页"
    },
    "sharing-plus": {
      "douban": false,
      "facebook": false,
      "google": false,
      "hatenaBookmark": false,
      "instapaper": false,
      "line": false,
      "linkedin": false,
      "messenger": false,
      "pocket": false,
      "qq": false,
      "qzone": false,
      "stumbleupon": false,
      "twitter": false,
      "viber": false,
      "vk": false,
      "weibo": false,
      "whatsapp": false,
      "all": ["github", "google", "weibo", "twitter", "facebook"]
    },
    "tbfed-pagefooter": {
      "copyright": "Copyright &copy; $(date +%Y) ${AUTHOR_NAME}",
      "modify_label": "最后更新：",
      "modify_format": "YYYY-MM-DD HH:mm:ss"
    }
  }
}
EOF

# 创建 SUMMARY.md
print_info "生成 SUMMARY.md..."
cat > SUMMARY.md << 'EOF'
# Summary

* [介绍](README.md)

## 技术文档
* [技术概览](docs/tech/README.md)
  * [Docker 相关](docs/tech/docker.md)
  * [Linux 操作](docs/tech/linux.md)
  * [编程笔记](docs/tech/programming.md)
  * [开发工具](docs/tech/tools.md)

## 工作记录
* [工作概览](docs/work/README.md)
  * [项目记录](docs/work/projects.md)
  * [会议纪要](docs/work/meetings.md)
  * [学习计划](docs/work/learning.md)
  * [问题解决](docs/work/troubleshooting.md)

## 资源收集
* [资源概览](docs/resources/README.md)
  * [实用工具](docs/resources/tools.md)
  * [参考链接](docs/resources/links.md)
  * [书籍推荐](docs/resources/books.md)
  * [课程推荐](docs/resources/courses.md)

## 其他
* [关于我](docs/about.md)
* [更新日志](docs/changelog.md)
* [FAQ](docs/faq.md)
EOF

# 创建 README.md
print_info "生成 README.md..."
cat > README.md << EOF
# ${REPO_NAME} 📚

> 个人知识库 - 记录学习路径，沉淀技术经验

## 🎯 快速导航

- **[技术文档](docs/tech/)** - 编程、运维、工具使用等技术笔记
- **[工作记录](docs/work/)** - 项目经验、会议纪要、学习计划
- **[资源收集](docs/resources/)** - 实用工具、参考资料、书籍推荐

## 🔥 最近更新

- $(date +%Y-%m-%d): 初始化知识库结构
- $(date +%Y-%m-%d): 添加基础模板和示例内容
- $(date +%Y-%m-%d): 配置 GitBook 主题和插件

## 💡 使用指南

1. **浏览内容**: 通过左侧导航栏浏览不同分类
2. **搜索内容**: 使用顶部搜索框查找特定内容  
3. **编辑内容**: 点击页面右上角的编辑按钮可直接修改
4. **添加内容**: 在对应目录创建新的 Markdown 文件

## 📝 写作规范

- 使用 Markdown 格式编写
- 文件名使用小写字母和连字符
- 图片存放在 \`assets/images/\` 目录
- 代码块要指定语言类型

## 🚀 部署说明

本知识库使用 GitHub Pages + GitBook 主题部署：

1. 推送代码到 GitHub 仓库
2. 启用 GitHub Pages (Settings > Pages > GitHub Actions)
3. 等待自动构建完成
4. 访问 \`https://username.github.io/${REPO_NAME}\`

## 📊 统计信息

- 创建时间: $(date +%Y-%m-%d)
- 作者: ${AUTHOR_NAME}
- 许可证: MIT

---

> 💭 **提示**: 这个知识库会持续更新，欢迎收藏和关注！
EOF

# 创建 index.md
print_info "生成 index.md..."
cat > index.md << EOF
---
layout: home
title: 首页
---

# 欢迎来到我的知识库 📚

这里是我的个人知识库，记录学习笔记、工作经验和有用资源。

## 🎯 快速导航

- **[技术文档](docs/tech/)** - 编程、运维、工具使用等技术笔记
- **[工作记录](docs/work/)** - 项目经验、会议纪要、学习计划  
- **[资源收集](docs/resources/)** - 实用工具、参考资料、书籍推荐

## 🔥 最近更新

- $(date +%Y-%m-%d): 初始化知识库
- $(date +%Y-%m-%d): 添加技术文档模板
- $(date +%Y-%m-%d): 配置自动化部署

## 💡 知识体系

\`\`\`mermaid
graph TD
    A[知识库] --> B[技术文档]
    A --> C[工作记录] 
    A --> D[资源收集]
    
    B --> B1[编程语言]
    B --> B2[开发工具]
    B --> B3[系统运维]
    
    C --> C1[项目管理]
    C --> C2[团队协作]
    C --> C3[问题解决]
    
    D --> D1[实用工具]
    D --> D2[学习资源]
    D --> D3[行业资讯]
\`\`\`

## 📈 学习目标

- [ ] 系统整理技术知识点
- [ ] 建立完整的学习路径
- [ ] 沉淀项目实战经验
- [ ] 构建个人知识图谱

---

> 💭 **座右铭**: 学而时习之，不亦说乎？
EOF

# 创建技术文档
print_info "生成技术文档..."

# docs/tech/README.md
cat > docs/tech/README.md << 'EOF'
# 技术文档

这里记录各种技术相关的学习笔记和实践经验。

## 📁 目录结构

### 编程开发
- [Docker 容器化](docker.md) - 容器技术学习和实践
- [Linux 系统](linux.md) - Linux 命令和系统管理
- [编程笔记](programming.md) - 各种编程语言和框架
- [开发工具](tools.md) - 提升开发效率的工具

### 学习方法
- 理论学习 + 实践操作
- 记录遇到的问题和解决方案
- 定期回顾和总结

## 🎯 学习路径

```mermaid
graph LR
    A[基础知识] --> B[实践项目]
    B --> C[深入理解]
    C --> D[分享总结]
    D --> A
```

## 📝 更新记录

- 持续更新中...
EOF

# docs/tech/docker.md
cat > docs/tech/docker.md << 'EOF'
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
EOF

# 创建其他文档文件
print_info "生成其他文档文件..."

# docs/tech/linux.md
cat > docs/tech/linux.md << 'EOF'
# Linux 系统管理

## 常用命令

### 文件操作
```bash
# 文件查看
ls -la          # 详细列表
find / -name "*config*"  # 查找文件
grep -r "keyword" .      # 搜索内容

# 文件编辑
vim filename    # 编辑文件
nano filename   # 简单编辑器

# 权限管理
chmod 755 filename      # 修改权限
chown user:group file   # 修改所有者
```

### 系统监控
```bash
# 系统信息
top           # 实时进程监控
htop          # 增强版top
ps aux        # 进程列表
df -h         # 磁盘使用情况
free -h       # 内存使用情况
```

## 服务管理

### Systemd
```bash
# 服务操作
systemctl start service_name
systemctl stop service_name
systemctl restart service_name
systemctl status service_name
systemctl enable service_name   # 开机自启
```

## 网络配置

### 基本网络命令
```bash
# 网络状态
netstat -tulpn    # 端口监听情况
ss -tulpn         # 现代版netstat
ping google.com   # 测试连通性
curl -I website   # 测试HTTP响应
```

---
*更多内容待补充...*
EOF

# docs/tech/programming.md
cat > docs/tech/programming.md << 'EOF'
# 编程笔记

## 编程语言

### Python
- 语法简洁，适合快速开发
- 强大的第三方库生态
- 适用于数据分析、Web开发、自动化

### JavaScript
- 前端必备语言
- Node.js 使其可用于后端开发
- 生态系统庞大

### Go
- 编译型语言，性能优秀
- 并发编程友好
- 适合微服务和云原生应用

## 开发框架

### Web 开发
- **React**: 前端UI库
- **Vue.js**: 渐进式前端框架
- **Express.js**: Node.js Web框架
- **Django**: Python Web框架

### 移动开发
- **React Native**: 跨平台移动应用
- **Flutter**: Google的跨平台方案

## 最佳实践

1. **代码规范**: 使用一致的代码风格
2. **版本控制**: 合理使用Git
3. **测试驱动**: 编写单元测试
4. **文档编写**: 保持代码和文档同步

---
*持续学习中...*
EOF

# 创建工作记录
cat > docs/work/README.md << 'EOF'
# 工作记录

记录工作中的项目经验、会议纪要和学习成长。

## 📂 内容分类

- [项目记录](projects.md) - 参与的项目和收获
- [会议纪要](meetings.md) - 重要会议记录
- [学习计划](learning.md) - 技能提升规划
- [问题解决](troubleshooting.md) - 工作中遇到的问题和解决方案

## 🎯 工作目标

- 提升技术能力
- 改善团队协作
- 完善项目管理
- 积累行业经验

---
*记录成长的每一步*
EOF

# 创建其他必要文件
cat > docs/work/projects.md << 'EOF'
# 项目记录

## 进行中项目

### 知识库系统
- **开始时间**: $(date +%Y-%m-%d)
- **目标**: 建立个人知识管理系统
- **技术栈**: GitHub Pages + GitBook
- **进度**: 初始化完成

## 项目模板

### 项目信息记录
- **项目名称**: 
- **开始时间**: 
- **预计完成**: 
- **技术栈**: 
- **团队成员**: 
- **项目目标**: 
- **关键里程碑**: 
- **遇到的挑战**: 
- **解决方案**: 
- **收获和反思**: 

---
*记录每个项目的成长*
EOF

# 创建资源收集
cat > docs/resources/README.md << 'EOF'
# 资源收集

收集和整理有用的工具、链接、书籍等资源。

## 📚 分类导航

- [实用工具](tools.md) - 提升效率的工具推荐
- [参考链接](links.md) - 有价值的网站和文章
- [书籍推荐](books.md) - 优质技术和管理书籍
- [课程推荐](courses.md) - 在线学习资源

## 🔍 收集原则

- 实用性强
- 质量可靠
- 定期更新
- 分类清晰

---
*知识的积累在于收集和整理*
EOF

# 创建GitHub Actions工作流
print_info "生成 GitHub Actions 配置..."
cat > .github/workflows/pages.yml << 'EOF'
name: Build and Deploy to GitHub Pages

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
          bundler-cache: true

      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v4

      - name: Install dependencies
        run: |
          gem install bundler
          bundle install

      - name: Build with Jekyll
        run: |
          bundle exec jekyll build --baseurl "${{ steps.pages.outputs.base_path }}"
        env:
          JEKYLL_ENV: production

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./_site

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
EOF

# 创建 Gemfile
print_info "生成 Gemfile..."
cat > Gemfile << 'EOF'
source "https://rubygems.org"

gem "jekyll", "~> 4.3"
gem "minima", "~> 2.5"

group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem "jekyll-sitemap"
  gem "jekyll-seo-tag"
end

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
EOF

# 创建 .gitignore
print_info "生成 .gitignore..."
cat > .gitignore << 'EOF'
# Jekyll
_site/
.sass-cache/
.jekyll-cache/
.jekyll-metadata

# GitBook
_book/
node_modules/

# Logs
*.log

# OS
.DS_Store
Thumbs.db

# Editor
.vscode/
.idea/
*.swp
*.swo

# Temporary files
*~
.tmp
EOF

# 创建其他必要文件
cat > docs/about.md << EOF
# 关于我

## 👋 个人简介

你好！我是 ${AUTHOR_NAME}，这里是我的个人知识库。

## 🚀 技术栈

- **编程语言**: Python, JavaScript, Go
- **框架工具**: React, Vue.js, Django
- **运维工具**: Docker, Kubernetes, Git
- **数据库**: MySQL, PostgreSQL, Redis

## 📫 联系方式

- **邮箱**: ${AUTHOR_EMAIL}
- **GitHub**: [github.com/username](https://github.com/username)

## 🎯 建立知识库的目标

1. 系统整理所学知识
2. 记录工作经验和心得
3. 分享有价值的资源
4. 建立个人技术品牌

---
*持续学习，持续分享*
EOF

cat > docs/changelog.md << 'EOF'
# 更新日志

记录知识库的重要更新和变化。

## [未发布]

### 新增
- 初始化知识库结构
- 添加基础文档模板
- 配置 GitHub Pages 自动部署

### 优化
- 完善目录结构
- 统一文档格式

### 修复
- 暂无

---

## 版本规划

### v1.0.0 - 基础版本
- [ ] 完善技术文档
- [ ] 添加更多示例
- [ ] 优化搜索功能

### v2.0.0 - 增强版本
- [ ] 添加评论功能
- [ ] 集成分析统计
- [ ] 支持多语言

---
*保持更新，记录成长*
EOF

# 初始化Git仓库
print_info "初始化 Git 仓库..."
git init

# 创建初始提交
git add .
git commit -m "🎉 初始化 GitBook 知识库

- 添加完整的目录结构
- 配置 Jekyll + GitBook 主题
- 设置 GitHub Actions 自动部署
- 创建基础文档模板和示例内容"

print_success "GitBook 知识库创建完成！"
echo
print_info "📁 项目结构:"
tree -I 'node_modules|.git' || ls -la

echo
print_info "🚀 下一步操作:"
echo "1. 推送到 GitHub 仓库:"
echo "   git remote add origin https://github.com/username/${REPO_NAME}.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo
echo "2. 启用 GitHub Pages:"
echo "   - 进入仓库 Settings > Pages"
echo "   - Source 选择 'GitHub Actions'"
echo
echo "3. 等待构建完成，访问:"
echo "   https://username.github.io/${REPO_NAME}"
echo
print_warning "💡 提示: 记得将 'username' 替换为你的 GitHub 用户名"

echo
print_success "🎉 恭喜！你的 GitBook 知识库已经准备就绪！"
EOF