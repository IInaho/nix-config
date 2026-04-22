{ config, pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      # 启用清理
      enable = true;
      # 清理操作的执行频率
      dates = "weekly";
      # 清理参数
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };
}
