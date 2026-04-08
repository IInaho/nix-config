{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings.user.name = "lznauy";
    settings.user.email = "lznauyfine@gmail.com";
  };
}
