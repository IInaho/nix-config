# Hosts

## 结构

```
hosts/
├── common/       # 共享模块（所有 host 共用）
├── vmware/       # VMware 虚拟机
├── physical/     # 物理机
└── virtual/      # k3s VM
```

每台机器的配置由 `default.nix`（系统） + `hardware.nix`（硬件）组成，共享模块统一放到 `common/`。

## 部署命令

```bash
# 重建当前系统（应用配置变更）
nh os switch /path/to/flake

# 重建但不设为默认（测试用，重启后回滚）
nh os boot /path/to/flake

# 仅构建、不激活（检查是否能通过）
nh os build /path/to/flake
```

## 切换 Host

```bash
# VMware 虚拟机
nh os switch /path/to/flake#nixos -H nixos

# 物理机
nh os switch /path/to/flake#physical -H nixos

# k3s VM（构建并启动 VM）
nh os build-vm /path/to/flake#vm-k3s
```

`-H hostname` 会临时覆盖目标主机名，避免 rebuild 时报 hostname 不匹配。

## 安装新系统

在 NixOS Live ISO 中执行：

```bash
# 1. 分区、格式化、挂载到 /mnt
# 2. 生成硬件配置（可选）
nixos-generate-config --root /mnt

# 3. 从 flake 安装（会使用对应 host 的配置）
nh os install /path/to/flake#physical /mnt

# 4. 重启进入新系统
reboot
```

## 更新依赖

```bash
# 更新 flake.lock（拉取所有 inputs 最新版）
nh os switch --update /path/to/flake
```

## 实用技巧

```bash
# 查看当前系统使用的 flake 来源
nixos-version --json

# 查看有哪些可用的 nixosConfiguration
nix flake show /path/to/flake

# 列出所有世代
nh os list-generations

# 切换到上一代（回滚）
nh os switch /path/to/flake -- --rollback
```
