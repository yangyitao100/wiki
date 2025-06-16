# GitHub Pages 自动部署 GitBook 设置指南

## 📋 概述

本指南将帮助您配置GitHub仓库，使其能够自动通过GitHub Pages部署GitBook风格的文档网站。

## 🛠️ 配置步骤

### 1. 启用GitHub Pages

1. 进入您的GitHub仓库
2. 点击 **Settings** 选项卡
3. 在侧边栏中找到 **Pages** 选项
4. 在 **Source** 部分选择 **GitHub Actions**
5. 点击 **Save** 保存设置

### 2. 确保文件结构正确

您的仓库应该包含以下文件：

```
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions工作流
├── docs/                       # 您的文档文件
├── book.json                   # GitBook配置
├── package.json               # Node.js依赖配置
├── SUMMARY.md                 # GitBook目录结构
├── index.md                   # 首页内容
├── .gitignore                 # Git忽略文件
└── README.md                  # 项目说明
```

### 3. 推送代码触发构建

当您将代码推送到 `main` 分支时，GitHub Actions会自动：

1. 检出代码
2. 设置Node.js环境
3. 安装GitBook CLI和插件
4. 构建GitBook网站
5. 部署到GitHub Pages

### 4. 查看构建状态

- 在仓库的 **Actions** 选项卡中查看构建状态
- 构建成功后，可以通过 `https://[username].github.io/[repository-name]` 访问网站

## 🎨 自定义配置

### 修改GitBook配置

编辑 `book.json` 文件来自定义：

- 网站标题和描述
- 启用/禁用插件
- 设置GitHub仓库链接
- 配置页面footer等

### 更新目录结构

编辑 `SUMMARY.md` 文件来更新网站的导航结构。

### 添加新页面

1. 在相应的目录下创建新的 `.md` 文件
2. 在 `SUMMARY.md` 中添加对应的链接
3. 推送代码，网站会自动更新

## 🔧 故障排除

### 构建失败

如果构建失败，请检查：

1. **Actions** 选项卡中的错误日志
2. `book.json` 文件语法是否正确
3. `SUMMARY.md` 中的链接是否都存在对应的文件
4. 插件是否兼容当前的GitBook版本

### 页面无法访问

如果网站无法访问，请确认：

1. GitHub Pages已正确启用
2. 仓库是公开的（或者您有GitHub Pro账户）
3. 构建已成功完成

### 样式问题

如果页面样式不正确：

1. 检查GitBook插件配置
2. 确认所有插件都已正确安装
3. 查看浏览器开发者工具中的错误信息

## 📝 注意事项

- **Node.js版本**: 使用Node.js 14.x版本以确保最佳兼容性
- **插件兼容性**: 某些老旧的GitBook插件可能不兼容最新版本
- **构建时间**: 首次构建可能需要几分钟时间
- **缓存**: GitHub Pages可能会缓存内容，更新后需要等待几分钟才能看到变化

## 🚀 进阶配置

### 自定义域名

如果您有自定义域名：

1. 在仓库根目录创建 `CNAME` 文件
2. 在文件中写入您的域名
3. 在DNS设置中配置CNAME记录

### 添加更多插件

1. 在 `book.json` 的 `plugins` 数组中添加插件名
2. 在 `package.json` 的 `dependencies` 中添加对应的包
3. 推送代码，系统会自动安装新插件

## 📞 获取帮助

如果遇到问题：

1. 查看GitHub Actions的构建日志
2. 参考GitBook官方文档
3. 在仓库的Issues中提问

---

✨ 现在您的GitBook文档网站已经配置完成，每次推送代码都会自动更新网站！ 