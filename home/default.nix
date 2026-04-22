{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.stateVersion = "26.05";

  imports = [
    ./git.nix
    ./gtk.nix
    ./shell/default.nix
    ./nixvim.nix
    ./noctalia.nix
    ./niri/default.nix
    ./kitty.nix
    ./fcitx5.nix
    ./fastfetch.nix
    ./fuzzel.nix
    ./hyprlock.nix
    ./nh.nix
  ];

  home.packages = with pkgs; [

    fastfetch # 查看系统信息
    tree # 目录树
    fd # find升级版
    ripgrep # grep的升级版
    bat # 代码格式化显示
    chafa # 图像转终端ascii显示
    yazi # 终端文件管理器
    tmux # 终端多路复用器
    sops # 配置加密
    nixfmt-tree # nix格式化工具
    just # 简化版makefile
    fzf # 终端模糊搜索神器

    claude-code
    opencode
    mcp-nixos

    git
    gcc
    gnumake
    nodejs
    python3
    go
    tree-sitter

    kitty
    google-chrome
    splayer
  ];
}
