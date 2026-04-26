{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprlock
  ];

  programs.hyprlock.enable = true;

  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
}
