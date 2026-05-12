# clash-verge - 代理/VPN 图形客户端
{ lib, ... }:
{
  programs.clash-verge = {
    enable = true;
    autoStart = true;
    tunMode = true;
    serviceMode = true;
  };
}
