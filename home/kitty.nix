{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 16;
    };

    settings = {
        dynamic_background_opacity = "yes";
        hide_window_decorations = "yes";
	backgroud_opacity = "0.92";
	tab_bar_edge = "bottom";
	tab_bar_min_tabs = "1";
	confirm_os_window_close = "0";
	tab_powerline_style = "slanted";
    };

    themeFile = "VSCode_Dark";
  };
}
