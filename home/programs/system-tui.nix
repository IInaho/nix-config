{ pkgs, ... }:

{
  home.packages = with pkgs; [
    isd # 交互式 systemd 单元查看器
    kmon # Linux 内核模块监控工具
  ];
}
