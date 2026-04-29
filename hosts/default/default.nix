{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../base.nix
    ./i18n.nix
    ./clash-verge.nix
    ./xwayland.nix
    ./secrets.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  networking.proxy.default = "http://192.168.1.142:7897/";
  networking.proxy.noProxy = "127.0.0.1,localhost";

  virtualisation.vmware.guest.enable = true;
  virtualisation.docker.enable = true;

  users.users.lznauy = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "users"
      "networkmanager"
      "docker"
    ];
  };

  users.users.lznauy.shell = pkgs.fish;

  programs.fish.enable = true;
  programs.zsh.enable = true;

  programs.niri.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;

  environment.sessionVariables = {
    QS_ICON_THEME = "WhiteSur-dark";
  };

  services.openssh.settings.AllowUsers = [ "lznauy" ];
}
