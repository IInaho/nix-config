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
    ./devtools.nix
  ];

  programs.obs-studio.enable = true; # OBS Studio 录屏软件

  home.packages = with pkgs; [
    gifski # mp4 转 gif 工具
    ffmpeg # 视频处理工具
    openssl
    age # 加密工具

    net-tools # 网络工具
    translate-shell # 命令行翻译工具
    libcaca # 终端彩色ASCII图像库
    yq # 类似jq, 可解析yaml
    jq # 解析json
    unzip # 解压zip
    duf # 查看系统磁盘的空间使用情况 better df
    iotop # 查看io监控
    cloc # 统计代码数
    doggo # dns终端可视化
    dive # docker image 分析工具
    lsof # 查询端口开放
    wget # 终端下载工具


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
    hugo # 博客框架

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

    # ai
    claude-code
    opencode
    mcp-nixos

    # app
    kitty # 终端
    google-chrome # 浏览器
    splayer # 音乐播放器
    qq # QQ 客户端
    telegram-desktop # Telegram 客户端
  ];
}
