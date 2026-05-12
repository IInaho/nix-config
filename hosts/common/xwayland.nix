{ pkgs, ... }:

{
  programs.xwayland.enable = true;
  services.xserver.enable = true;

  environment.systemPackages = [
    pkgs.xwayland-satellite # XWayland 兼容层桥接器
  ];
}
