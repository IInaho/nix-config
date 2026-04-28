# kitty - GPU 加速终端模拟器
{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;

    # 字体由 stylix target 自动配置

    settings = {
      dynamic_background_opacity = "yes";
      hide_window_decorations = "yes";
      background_opacity = lib.mkForce "0.95";
      tab_bar_edge = "bottom";
      tab_bar_min_tabs = "1";
      confirm_os_window_close = "0";
      tab_powerline_style = "slanted";
      allow_hyperlinks = "no";
    };

  };
}
