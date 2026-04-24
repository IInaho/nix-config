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
    ./niri/default.nix
    ./niri/noctalia.nix
    ./kitty.nix
    ./fcitx5.nix
    ./fastfetch.nix
    ./fuzzel.nix
    ./hyprlock.nix
    ./nh.nix
    ./cava.nix
    ./btm.nix
    ./xdg/default.nix
    ./xdg/mime.nix
    ./xdg/autostart.nix
    ./xdg/desktop-files.nix
  ];

  home.packages = with pkgs; [

    net-tools # 网络工具
    translate-shell # 命令行翻译工具
    libcaca # 终端彩色ASCII图像库
    yq # 类似jq, 可解析yaml
    jq # 解析json
    unzip # 解压zip
    duf # 查看系统磁盘的空间使用情况 better df

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
    lazygit # git终端工具

    asciinema # 终端视频录制工具
    asciinema-agg # cast -> gif
    # asciinema rec demo.cast
    # asciinema play demo.cast

    isd # systemd TUI
    kmon # 内核编译和管理TUI

    # 截图
    grim
    slurp
    wl-clipboard

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
    qq # QQ 客户端
    telegram-desktop # Telegram 客户端
  ];
}
