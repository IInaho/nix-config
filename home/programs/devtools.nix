{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    gnumake
    nodejs
    python3
    python3Packages.pip
    go
    tree-sitter
  ];
}
