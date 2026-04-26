{ config, pkgs, ... }:

{
  home.packages = [ pkgs.starship ]; # 跨 shell 美化提示符

  xdg.configFile."starship.toml".source = ./starship.toml;

  programs.fish = {
    enable = true;
    shellInit = "set -x TERM xterm-256color";
    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  programs.starship = {
    enable = true;
    package = pkgs.starship;
  };
}
