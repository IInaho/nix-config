# 所有 VM 共享的基础配置
{ pkgs, ... }:
{
  # QEMU/KVM 客户端
  services.qemuGuest.enable = true;

  # 串口控制台（无图形界面时可通过终端管理 VM）
  boot.kernelParams = [ "console=ttyS0,115200" ];
  systemd.services."serial-getty@ttyS0".enable = true;

  # DHCP 自动获取网络
  networking.useDHCP = true;

  # VM 通用工具
  environment.systemPackages = with pkgs; [
    iproute2
    inetutils
  ];
}
