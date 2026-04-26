# Agenix 密钥迁移指南

## 新机器恢复流程

### 1. 克隆仓库

```bash
git clone <your-repo> && cd <repo>
```

### 2. 恢复 age 私钥

```bash
mkdir -p ~/.config/sops/age
nix-shell -p age --run "age -d secrets/age-key.age > ~/.config/sops/age/keys.txt"
chmod 600 ~/.config/sops/age/keys.txt
```

输入你设置的密码即可解密私钥。

### 3. 构建系统

```bash
sudo nixos-rebuild switch --flake .
```

构建时 agenix 会自动用私钥解密 `secrets/opencode.json.age`，并将明文放置到 `/run/agenix/opencode-json`，再通过 `xdg.configFile` 软链接到 `~/.config/opencode/config.json`。

## 日常操作

### 编辑加密文件

```bash
nix run github:ryantm/agenix -- -e secrets/opencode.json.age
```

此命令会自动解密、打开编辑器、保存后重新加密。

### 添加新的加密文件

1. 将明文文件放入仓库根目录（如 `new-secret.json`）
2. 加密：

```bash
nix-shell -p age --run "age -r age12x9w2t9tr3uswn4wzefcg6lzf8fm57t8r4aty0xy0egtlk5yyyzsmpdr7x -o secrets/new-secret.json.age new-secret.json"
```

3. 在 `secrets/secrets.nix` 中添加声明：

```nix
"new-secret.json.age".publicKeys = [ lznauy ];
```

4. 在 `hosts/default/secrets.nix` 中添加：

```nix
age.secrets.new-secret = {
  file = ../../secrets/new-secret.json.age;
  owner = "lznauy";
  group = "users";
};
```

5. 将明文文件加入 `.gitignore`
6. 按需配置 home-manager 引用解密后的文件

### 轮换 API Key

1. 用 `agenix -e secrets/opencode.json.age` 编辑，替换 apiKey
2. 保存后重新构建：`sudo nixos-rebuild switch --flake .`

## 文件说明

| 文件 | 用途 | 是否提交 git |
|------|------|-------------|
| `~/.config/sops/age/keys.txt` | age 私钥（解密用） | 否 |
| `secrets/age-key.age` | 私钥的密码加密备份（迁移用） | 是 |
| `secrets/opencode.json.age` | 加密后的 opencode 配置 | 是 |
| `secrets/secrets.nix` | 声明哪些文件用哪些公钥加密 | 是 |
| `opencode.json` | 明文配置（编辑用） | 否（.gitignore） |

## 安全提醒

- **永远不要**将 `keys.txt` 私钥提交到 git
- 如果怀疑私钥泄露，立即轮换 API Key 并重新生成 age 密钥对
- `secrets/age-key.age` 有密码保护，可安全提交
