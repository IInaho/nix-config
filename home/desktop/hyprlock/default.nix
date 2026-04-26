{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprlock # Hyprland 锁屏工具
  ];

  programs.hyprlock.enable = true;

  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
}
