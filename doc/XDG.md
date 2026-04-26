# XDG Dotfile 管理规范

> 本文档为项目内新增软件包时，其 dotfile 的 XDG 规范化管理参考。
> 基于 [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) 与 NixOS/Home Manager 社区最佳实践。

## 1. XDG 标准目录

| 变量 | 默认路径 | 用途 | 生命周期 |
|------|----------|------|----------|
| `XDG_CONFIG_HOME` | `~/.config` | 配置文件 | 持久，用户手动编辑 |
| `XDG_DATA_HOME` | `~/.local/share` | 应用数据 | 持久，应用自动读写 |
| `XDG_CACHE_HOME` | `~/.cache` | 缓存 | 可随时删除，应用自动重建 |
| `XDG_STATE_HOME` | `~/.local/state` | 状态/历史 | 持久，但可丢失不影响功能 |

**核心原则：家目录 `~/` 下不应出现任何应用生成的 dotfile/dotdir，仅保留 XDG 四个标准目录和不可避免的系统文件。**

## 2. 新增软件时的操作清单

新增任何软件包时，按以下步骤检查：

### Step 1: 确认该软件是否原生支持 XDG

查阅 [Arch Wiki XDG 目录支持列表](https://wiki.archlinux.org/title/XDG_Base_Directory#Supported) 或软件官方文档。

- **原生支持** → 通常无需额外配置，HM 模块可能已自动处理
- **通过环境变量支持** → 在 `home/xdg/default.nix` 的 `home.sessionVariables` 中设置
- **不支持** → 记录在下方"不可迁移"列表中，接受现实

### Step 2: 使用 Home Manager 模块而非 `home.packages`

优先使用 `programs.<name>` 或 `services.<name>` 模块，它们通常内置 XDG 支持：

```nix
# ✅ 推荐：HM 模块自动将配置写入 XDG 路径
programs.git = { enable = true; ... };       # → ~/.config/git/config
programs.kitty = { enable = true; ... };     # → ~/.config/kitty/kitty.conf

# ❌ 避免：手动安装 + home.file 写配置
home.packages = [ pkgs.git ];
home.file.".gitconfig".source = ./gitconfig;
```

### Step 3: 选择正确的 HM 文件管理原语

| 场景 | 使用 | 解析路径 |
|------|------|----------|
| 配置文件 | `xdg.configFile."app/file"` | `~/.config/app/file` |
| 应用数据 | `xdg.dataFile."app/file"` | `~/.local/share/app/file` |
| 缓存文件（罕见） | 手动在 `sessionVariables` 指定 | `~/.cache/app/` |
| 状态/历史文件 | 手动在 `sessionVariables` 指定 | `~/.local/state/app/` |
| 敏感配置 | `xdg.configFile."app/file".source = mkOutOfStoreSymlink ...` | `~/.config/app/file` → agenix |

**绝对不要使用** `home.file.".config/..."` 或 `home.file.".local/share/..."`，改用 `xdg.configFile` / `xdg.dataFile`。

### Step 4: 添加环境变量（如需要）

在 `home/xdg/default.nix` 的 `home.sessionVariables` 中添加，使用 `config.xdg.*` 引用路径而非硬编码：

```nix
home.sessionVariables = {
  # ✅ 正确：引用 config.xdg.*，路径随 XDG 配置自动变化
  GOPATH = "${config.xdg.dataHome}/go";

  # ❌ 错误：硬编码路径
  GOPATH = "/home/lznauy/.local/share/go";
};
```

## 3. 常见软件 XDG 迁移速查表

### Shell / 历史

| 软件 | 变量/配置 | 目标路径 |
|------|-----------|----------|
| Zsh | `programs.zsh.history.path` | `${xdg.stateHome}/zsh/history` |
| Zsh 补全缓存 | `ZSH_COMPDUMP` (initContent) | `${xdg.cacheHome}/zsh/zcompdump` |
| Bash | `programs.bash.historyFile` | `${xdg.stateHome}/bash/history` |
| Python REPL | `PYTHON_HISTORY` | `${xdg.stateHome}/python/history` |
| Less | `LESSHISTFILE` | `${xdg.stateHome}/less/history` |
| Readline | `INPUTRC` | `${xdg.configHome}/readline/inputrc` |

### 开发工具

| 软件 | 变量/配置 | 目标路径 |
|------|-----------|----------|
| Go | `GOPATH` | `${xdg.dataHome}/go` |
| Cargo/Rust | `CARGO_HOME` | `${xdg.dataHome}/cargo` |
| npm | `NPM_CONFIG_USERCONFIG` + `NPM_CONFIG_CACHE` | config + cache |
| wget | `WGETRC` | `${xdg.configHome}/wget/wgetrc` |
| GnuPG | `GNUPGHOME` | `${xdg.dataHome}/gnupg` |
| Node.js | `NODE_REPL_HISTORY` | `${xdg.stateHome}/node/repl_history` |
| Rustup | `RUSTUP_HOME` | `${xdg.dataHome}/rustup` |
| pip | `PIP_CONFIG_FILE` | `${xdg.configHome}/pip/pip.conf` |
| Poetry | `POETRY_CONFIG_DIR` + `POETRY_CACHE_DIR` | config + cache |
| Maven | `M2_HOME` + `MAVEN_OPTS` | `${xdg.dataHome}/maven` |
| Gradle | `GRADLE_USER_HOME` | `${xdg.dataHome}/gradle` |
| Docker | `DOCKER_CONFIG` | `${xdg.configHome}/docker` |
| Terraform | `TF_CLI_CONFIG_FILE` | `${xdg.configHome}/terraform/terraformrc` |
| Kubenetes | `KUBECONFIG` | `${xdg.configHome}/kube/config` |
| Helm | `HELM_HOME` | `${xdg.dataHome}/helm` |
| Conan | `CONAN_USER_HOME` (指向 dataHome 父级) | `${xdg.dataHome}/conan` |

### 编辑器 / TUI

| 软件 | 变量/配置 | 目标路径 |
|------|-----------|----------|
| Vim | `VIM` + `VIMINIT` | config + state |
| Neovim | 原生支持 XDG | `~/.config/nvim/` ✅ |
| tmux | `programs.tmux` → 自动 `~/.config/tmux/` | `${xdg.configHome}/tmux` |
| lazygit | 原生支持 XDG | `~/.config/lazygit/` ✅ |

### 桌面应用

| 软件 | 变量/配置 | 目标路径 |
|------|-----------|----------|
| GTK 3/4 | HM 自动管理 | `${xdg.configHome}/gtk-3.0/` ✅ |
| GTK 2 | ❌ 硬编码 `~/.gtkrc-2.0` | 不可迁移 |
| SSH | ❌ 硬编码 `~/.ssh` | 不可迁移 |
| Chromium/Electron | 部分支持 | `~/.config/` ✅ |

## 4. 不可迁移的 dotfile（白名单）

以下文件因应用硬编码，**无法**迁移到 XDG 路径，是家目录中允许存在的例外：

| 文件 | 原因 |
|------|------|
| `.bash_profile` / `.bashrc` / `.profile` | Bash/POSIX 启动硬编码，HM symlink |
| `.ssh/` | OpenSSH 源码硬编码，社区补丁多年未被接受 |
| `.pki/` | NSS/Chromium 硬编码 |
| `.nix-defexpr/` | Nix 遗留行为 |
| `.gtkrc-2.0` | GTK2 源码硬编码 |

新增不可迁移的 dotfile 时，须在此表中登记原因。

## 5. 项目文件组织规范

```
home/
├── default.nix          # 入口，imports 所有子模块
├── xdg/
│   ├── default.nix      # xdg.enable + sessionVariables + programs.bash
│   ├── mime.nix         # xdg.mimeApps 默认应用关联
│   ├── autostart.nix    # xdg.autostart 自启动
│   ├── desktop-files.nix # xdg.dataFile desktop 文件
│   └── secrets.nix      # xdg.configFile + agenix 敏感配置
├── shell/
│   ├── default.nix
│   ├── fish/            # fish + starship 配置
│   └── zsh/             # zsh + p10k 配置
├── git.nix              # programs.git
├── kitty.nix            # programs.kitty
└── devtools.nix         # 开发工具包（仅 home.packages）
```

**规则**：
- 有 HM 模块的软件 → 独立 `programs.<name>` 文件，配置自然归入 XDG
- 无 HM 模块的软件 → `home.packages` 安装，环境变量在 `xdg/default.nix` 统一管理
- Desktop 文件 → `xdg/desktop-files.nix` 中用 `xdg.dataFile`
- 敏感配置 → `xdg/secrets.nix` 中用 `xdg.configFile` + `mkOutOfStoreSymlink`

## 6. 新增软件 Checklist

添加新软件时，逐项确认：

- [ ] 该软件是否原生支持 XDG？查阅 Arch Wiki
- [ ] 是否有 `programs.<name>` 或 `services.<name>` HM 模块可用？搜索 [Home Manager Option Search](https://nix-community.github.io/home-manager/options.html)
- [ ] 配置文件是否放在 `xdg.configFile` 而非 `home.file`？
- [ ] 数据文件是否放在 `xdg.dataFile` 而非 `home.file`？
- [ ] 是否需要添加 `sessionVariables` 来覆盖默认路径？
- [ ] 历史/状态文件是否指向 `${xdg.stateHome}`？
- [ ] 缓存文件是否指向 `${xdg.cacheHome}`？
- [ ] 如不可迁移，是否在白名单中登记了原因？
- [ ] `nixos-rebuild build` 构建通过？
- [ ] 部署后家目录无新增非 XDG dotfile？
