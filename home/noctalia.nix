{ config, pkgs, ... }:
{
  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      general = {
        language = "zh-CN";
      };
      ui = {
        fontDefault = "Noto Sans CJK SC";
        fontFixed = "JetBrainsMono Nerd Font";
        fontDefaultScale = 1;
        fontFixedScale = 1;
      };
      bar = {
        position = "top";
        density = "comfortable";
        fontScale = 1.1;
        marginVertical = 8;
        marginHorizontal = 8;
        contentPadding = 4;
      };
      wallpaper = {
        enabled = true;
        useSolidColor = false;
      };
    };
  };

  home.file.".config/noctalia/wallpapers/wallpaper.png".source = ./wallpapers/wallpaper.png;
  home.file.".cache/noctalia/wallpapers.json".text = builtins.toJSON {
    defaultWallpaper = "${config.home.homeDirectory}/.config/noctalia/wallpapers/wallpaper.png";
    wallpapers = { };
  };
}