#!/bin/bash

# GitBook 知识库设置脚本
# 用于快速设置和部署 GitBook 风格的知识库

echo "🚀 开始设置 GitBook 知识库..."

# 检查必要的工具
check_prerequisites() {
    echo "📋 检查系统依赖..."
    
    # 检查 Ruby
    if ! command -v ruby &> /dev/null; then
        echo "❌ Ruby 未安装，请先安装 Ruby"
        exit 1
    fi
    
    # 检查 Bundler
    if ! command -v bundle &> /dev/null; then
        echo "📦 安装 Bundler..."
        gem install bundler
    fi
    
    # 检查 Git
    if ! command -v git &> /dev/null; then
        echo "❌ Git 未安装，请先安装 Git"
        exit 1
    fi
    
    echo "✅ 系统依赖检查完成"
}

# 安装依赖
install_dependencies() {
    echo "📦 安装 Jekyll 和插件依赖..."
    
    if [ -f "Gemfile" ]; then
        bundle install
        if [ $? -eq 0 ]; then
            echo "✅ 依赖安装成功"
        else
            echo "❌ 依赖安装失败"
            exit 1
        fi
    else
        echo "❌ 未找到 Gemfile 文件"
        exit 1
    fi
}

# 初始化 Git（如果需要）
init_git() {
    if [ ! -d ".git" ]; then
        echo "🔧 初始化 Git 仓库..."
        git init
        git add .
        git commit -m "Initial commit: Setup GitBook knowledge base"
        echo "✅ Git 仓库初始化完成"
    else
        echo "✅ Git 仓库已存在"
    fi
}

# 创建缺失的文件
create_missing_files() {
    echo "📝 检查并创建缺失的文件..."
    
    # 创建缺失的文档文件
    missing_files=(
        "docs/work/meetings.md"
        "docs/work/learning.md"
        "docs/work/troubleshooting.md"
        "docs/resources/tools.md"
        "docs/resources/links.md"
        "docs/resources/books.md"
        "docs/resources/courses.md"
    )
    
    for file in "${missing_files[@]}"; do
        if [ ! -f "$file" ]; then
            echo "📄 创建文件: $file"
            mkdir -p "$(dirname "$file")"
            cat > "$file" << EOF
---
title: $(basename "$file" .md | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
description: 文档描述
---

# $(basename "$file" .md | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')

## 概述
TODO: 添加内容描述

## 内容

<!-- 在这里添加你的内容 -->

---

> 📝 **最后更新**: $(date '+%Y-%m-%d')
EOF
        fi
    done
    
    echo "✅ 文件检查完成"
}

# 验证配置
validate_config() {
    echo "🔍 验证配置文件..."
    
    # 检查重要文件
    important_files=("_config.yml" "SUMMARY.md" "index.md" "book.json")
    
    for file in "${important_files[@]}"; do
        if [ ! -f "$file" ]; then
            echo "❌ 缺少重要文件: $file"
            exit 1
        fi
    done
    
    echo "✅ 配置文件验证完成"
}

# 本地测试
test_local() {
    echo "🧪 启动本地测试服务器..."
    
    # 尝试启动 Jekyll 服务器
    echo "📡 启动服务器在 http://localhost:4000"
    echo "⏹️  按 Ctrl+C 停止服务器"
    echo ""
    
    bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload
}

# GitHub Pages 部署提示
github_pages_setup() {
    echo ""
    echo "🌐 GitHub Pages 部署说明:"
    echo "=============================="
    echo "1. 推送代码到 GitHub 仓库"
    echo "2. 在仓库设置中启用 GitHub Pages"
    echo "3. 选择 'Deploy from a branch'"
    echo "4. 选择 'main' 分支和 '/ (root)' 文件夹"
    echo "5. 等待几分钟后访问你的站点"
    echo ""
    echo "📝 推送命令示例:"
    echo "git remote add origin https://github.com/username/repo.git"
    echo "git branch -M main"
    echo "git push -u origin main"
    echo ""
}

# 主函数
main() {
    echo "🎯 GitBook 知识库自动化设置"
    echo "================================"
    
    # 解析命令行参数
    case "$1" in
        "install")
            check_prerequisites
            install_dependencies
            create_missing_files
            validate_config
            echo "✅ 安装完成！运行 './setup-gitbook.sh serve' 启动本地服务器"
            ;;
        "serve")
            test_local
            ;;
        "deploy")
            github_pages_setup
            ;;
        *)
            echo "使用方法:"
            echo "  $0 install  - 安装依赖和设置环境"
            echo "  $0 serve    - 启动本地开发服务器"
            echo "  $0 deploy   - 显示 GitHub Pages 部署说明"
            echo ""
            echo "示例："
            echo "  $0 install && $0 serve"
            ;;
    esac
}

# 执行主函数
main "$@" 