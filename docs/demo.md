# 🎨 GitBook功能演示

这个页面用来展示我们GitBook网站的所有功能特性。

## 📋 界面布局

### 三栏布局说明

这个GitBook网站采用了完整的三栏布局设计：

1. **左侧导航栏** - 显示完整的章节目录树
2. **主内容区域** - 当前页面的内容
3. **右侧目录** - 当前页面内的标题导航

### 顶部工具栏

顶部固定工具栏包含：
- 网站标题
- 搜索框（可以搜索全站内容）
- 编辑按钮

## 🔧 功能特性演示

### 代码高亮

支持多种编程语言的语法高亮：

#### JavaScript 示例
```javascript
function fibonacci(n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

console.log(fibonacci(10)); // 输出: 55
```

#### Python 示例
```python
def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    
    return quick_sort(left) + middle + quick_sort(right)

# 使用示例
numbers = [3, 6, 8, 10, 1, 2, 1]
print(quick_sort(numbers))
```

#### Shell 脚本示例
```bash
#!/bin/bash

# 检查系统信息
echo "系统信息："
uname -a

# 检查磁盘使用情况
echo -e "\n磁盘使用情况："
df -h

# 检查内存使用情况
echo -e "\n内存使用情况："
free -h
```

### 表格展示

| 功能 | 状态 | 描述 |
|------|------|------|
| 🔍 搜索功能 | ✅ 已启用 | 支持全站内容搜索 |
| 📝 在线编辑 | ✅ 已启用 | 每页都有编辑链接 |
| 💾 代码复制 | ✅ 已启用 | 代码块可一键复制 |
| 📱 响应式设计 | ✅ 已启用 | 适配各种设备 |
| 🎨 自定义主题 | ✅ 已启用 | 专业的GitBook样式 |

### 引用和提示

> **💡 提示**: 这是一个引用块示例，可以用来突出重要信息。

> **⚠️ 注意**: 在编辑文档时，请确保链接的正确性。

> **📚 参考**: 查看 [官方文档](https://docs.gitbook.com/) 了解更多GitBook功能。

### 列表功能

#### 有序列表
1. **第一步**: 配置GitHub仓库
2. **第二步**: 设置GitHub Actions
3. **第三步**: 启用GitHub Pages
4. **第四步**: 推送代码触发部署

#### 无序列表
- ✨ 完整的三栏布局
- 🔍 智能搜索功能
- 📝 在线编辑支持
- 💾 代码复制功能
- 📱 响应式设计
- 🎨 专业主题样式

#### 嵌套列表
- **技术文档**
  - Docker相关
    - 容器化基础
    - Docker Compose
    - 容器编排
  - Kubernetes
    - 集群管理
    - 服务发现
    - 负载均衡
- **工作记录**
  - 项目记录
  - 会议纪要
  - 学习计划

## 🔗 链接功能

### 内部链接
- [技术文档](tech/README.md)
- [工作记录](work/README.md)
- [资源收集](resources/README.md)
- [关于我](about.md)

### 外部链接
- [GitHub 官网](https://github.com/)
- [GitBook 官网](https://www.gitbook.com/)
- [Markdown 语法](https://daringfireball.net/projects/markdown/)

## 📊 数学公式

支持LaTeX数学公式渲染：

行内公式：这是一个行内公式 $E = mc^2$

块级公式：
$$
\sum_{i=1}^{n} i = \frac{n(n+1)}{2}
$$

$$
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
$$

## 🎯 导航测试

### 二级标题 A
这是二级标题A的内容，用于测试右侧目录导航功能。

#### 三级标题 A1
这是三级标题A1的内容。

#### 三级标题 A2
这是三级标题A2的内容。

### 二级标题 B
这是二级标题B的内容。

#### 三级标题 B1
这是三级标题B1的内容。

##### 四级标题 B1a
这是四级标题B1a的内容。

##### 四级标题 B1b
这是四级标题B1b的内容。

#### 三级标题 B2
这是三级标题B2的内容。

### 二级标题 C
这是二级标题C的内容，包含更多的文本来测试页面滚动和导航功能。

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

## 🔄 互动功能

### 搜索测试
尝试使用顶部的搜索框搜索以下关键词：
- "Docker"
- "Kubernetes"
- "Python"
- "Git"

### 编辑功能
点击页面右上角的"编辑本页"按钮可以直接在GitHub上编辑这个文件。

### 复制功能
将鼠标悬停在代码块上，会出现复制按钮，可以一键复制代码。

### 返回顶部
在页面底部可以看到"返回顶部"按钮，点击可以快速回到页面顶部。

## 📱 响应式测试

这个网站支持完整的响应式设计：

- **桌面端**: 显示完整的三栏布局
- **平板端**: 自动调整布局，优化阅读体验
- **手机端**: 左侧导航栏可以通过菜单按钮打开/关闭

## 🎨 样式展示

### 强调文本
- **粗体文本**
- *斜体文本*
- ***粗斜体文本***
- ~~删除文本~~
- `行内代码`

### 分割线

---

### 图标和表情
支持emoji表情：😀 🎉 🚀 💻 📚 🔧 ⚡ 🌟

## 📝 总结

这个演示页面展示了GitBook网站的所有主要功能：

1. ✅ **完整三栏布局** - 左侧导航、主内容、右侧目录
2. ✅ **代码高亮** - 支持多种编程语言
3. ✅ **搜索功能** - 全站内容搜索
4. ✅ **编辑功能** - 在线编辑支持
5. ✅ **响应式设计** - 适配所有设备
6. ✅ **专业样式** - 真正的GitBook体验

现在您的知识库已经具备了专业级的GitBook功能！🎊 