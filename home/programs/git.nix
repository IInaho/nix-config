# git - 分布式版本控制系统
{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings.user.name = "lznauy";
    settings.user.email = "lznauyfine@gmail.com";
  };
}
