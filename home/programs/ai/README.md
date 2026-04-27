# Skill 安装指南

## 目录结构

```
skills/
├── default.nix      # 聚合所有 skill 源
├── waza.nix         # 多 skill 仓库示例
└── kami.nix         # 单 skill 仓库示例
```

## 新增 Skill

### 1. 获取仓库信息

```bash
git ls-remote https://github.com/<owner>/<repo>.git HEAD
nix-prefetch-url --unpack "https://github.com/<owner/<repo>/archive/<commit>.tar.gz"
```

### 2. 创建 `skills/<name>.nix`

**多 skill 仓库**（仓库根下有 `skills/<name>/SKILL.md`）：

```nix
{ pkgs, ... }:
let
  src = pkgs.fetchFromGitHub {
    owner = ""; repo = ""; rev = ""; sha256 = "";
  };
in
{
  skills = builtins.listToAttrs (
    map (name: { inherit name; value = "${src}/skills/${name}"; }) [ "skill-a" "skill-b" ]
  );
  context = "${src}/CLAUDE.md";   # 可选
}
```

**单 skill 仓库**（仓库根下直接是 `SKILL.md`）：

```nix
{ pkgs, ... }:
let
  src = pkgs.fetchFromGitHub {
    owner = ""; repo = ""; rev = ""; sha256 = "";
  };
  dir = pkgs.runCommand "<name>-skill" { } ''
    mkdir -p $out/<name>
    ln -s ${src}/SKILL.md $out/<name>/SKILL.md
    ln -s ${src}/references $out/<name>/references   # 按需
  '';
in
{
  skills."<name>" = "${dir}/<name>";
  context = "${src}/CLAUDE.md";   # 可选
}
```

### 3. 注册到 `skills/default.nix`

```nix
let
  waza = import ./waza.nix { inherit pkgs; };
  kami = import ./kami.nix { inherit pkgs; };
  new  = import ./new.nix  { inherit pkgs; };
in
{
  all-skills  = waza.skills // kami.skills // new.skills;
  all-rules   = waza.rules;                    # 按需合并
  all-context = waza.context + "\n\n" + kami.context + "\n\n" + new.context;
}
```

### 4. 验证

```bash
git add home/programs/ai/
nix build .#nixosConfigurations.nixos.config.home-manager.users.lznauy.home.activationPackage
```

## 注意

- 值传 store path string（`"${src}/path"`），不要传 derivation 本身
- 单 skill 仓库用 `runCommand` 重组，避免把 README/LICENSE 等无关文件带入
- 新文件必须先 `git add` 才能被 nix flake 识别
