{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
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

  nix.settings.substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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

  environment.systemPackages = with pkgs; [
    wget # HTTP 下载工具
    git # 版本控制系统
    curl # 命令行 HTTP 请求工具
    htop # 交互式进程监控器
    vim # 终端文本编辑器
  ];

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.AllowUsers = [ "lznauy" ];

  system.stateVersion = "26.05";
}
