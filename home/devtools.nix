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
  ];
}
