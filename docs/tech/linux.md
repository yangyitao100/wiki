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
