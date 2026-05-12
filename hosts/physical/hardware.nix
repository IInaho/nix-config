{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [
    "uhci_hcd"
    "ehci_pci"
    "ahci"
    "nvme"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # TODO: 在物理机上运行 nixos-generate-config 生成实际的磁盘配置
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/CHANGE-ME-ROOT";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CHANGE-ME-BOOT";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
