{ config, lib, pkgs, ... }:

{
  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
    };
    supportedLocales = [
      "zh_CN.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];

    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-mellow-themes
        qt6Packages.fcitx5-chinese-addons
      ];
      fcitx5.waylandFrontend = true;
    };
  };

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "fcitx";
  };

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font"
        ];
        serif = [ "Noto Serif CJK SC" ];
        sansSerif = [ "Noto Sans CJK SC" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}