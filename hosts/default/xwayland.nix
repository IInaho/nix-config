{ pkgs, ... }:

{
  programs.xwayland.enable = true;
  services.xserver.enable = true;

  environment.systemPackages = [
    pkgs.xwayland-satellite
  ];
}
