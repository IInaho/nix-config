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
        language = "zh-CN";
        fontDefault = "Noto Sans CJK SC";
        fontFixed = "JetBrainsMono Nerd Font";
        fontDefaultScale = 1.1;
        fontFixedScale = 1.1;
      };
      bar = {
        position = "top";
        density = "spacious";
        fontScale = 1.0;
        marginVertical = 12;
        marginHorizontal = 12;
        contentPadding = 6;
        widgets = {
          center = [
            {
              id = "Workspace";
              iconScale = 1.0;
              pillSize = 0.9;
            }
            {
              id = "Taskbar";
              iconScale = 1.0;
            }
          ];
        };
      };
      wallpaper = {
        enabled = true;
        useSolidColor = false;
      };
      colorSchemes = {
        predefinedScheme = "Dracula";
        darkMode = true;
      };
    };
  };

  home.file.".config/noctalia/wallpapers/wallpaper.png".source = ./wallpapers/wallpaper.png;
  home.file.".cache/noctalia/wallpapers.json".text = builtins.toJSON {
    defaultWallpaper = "${config.home.homeDirectory}/.config/noctalia/wallpapers/wallpaper.png";
    wallpapers = { };
  };
}