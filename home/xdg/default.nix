{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    xdg-utils      # xdg-open 等命令行工具
    xdg-user-dirs  # 自动创建用户目录
  ];

  xdg = {
    enable = true;

    # XDG 标准目录配置
    cacheHome  = "${config.home.homeDirectory}/.cache";      # 缓存
    configHome = "${config.home.homeDirectory}/.config";     # 配置
    dataHome   = "${config.home.homeDirectory}/.local/share"; # 数据
    stateHome  = "${config.home.homeDirectory}/.local/state"; # 状态

    userDirs = {
      enable = true;
      createDirectories = true;  # 自动创建 ~/Desktop, ~/Downloads 等目录

      # 自定义用户目录
      extraConfig = {
        SCREENSHOTS = "${config.xdg.userDirs.pictures}/Screenshots";
        DOWNLOADS   = "${config.home.homeDirectory}/Downloads";
      };
    };
  };
}
