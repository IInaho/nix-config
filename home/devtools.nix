{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # 开发工具
    git
    gcc
    gnumake
    nodejs
    python3
    go
    tree-sitter
    nodePackages.vite # 前端构建工具
  ];
}
