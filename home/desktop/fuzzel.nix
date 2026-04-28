# fuzzel - Wayland 应用启动器
{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        # 字体由 stylix target 自动配置
        line-height = 25;
        fields = "name,generic,comment,categories,filename,keywords";
        terminal = "kitty";
        prompt = "' ➜  '";
        icon-theme = "Papirus-Dark";
        layer = "top";
        lines = 10;
        width = 35;
        horizontal-pad = 25;
        inner-pad = 5;
      };
      # 颜色由 stylix target 自动配置
      border = {
        radius = 15;
        width = 3;
      };
    };
  };
}
