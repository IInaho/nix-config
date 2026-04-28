# cava - 音频频谱可视化工具
{
  config,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;
in
{
  programs.cava = {
    enable = true;
    settings = {
      general = {
        framerate = 60; # 示例值，更保守
        autosens = 1; # 一致，启用自动灵敏度
        sensitivity = 100; # 示例值，初始灵敏度稍低
        bars = 0; # 一致，自动填充
        bar_width = 2; # 示例值，柱宽 2 字符
        bar_spacing = 1; # 示例值，间距 1 字符
        lower_cutoff_freq = 50; # 示例值，窄化低频范围
        higher_cutoff_freq = 10000; # 示例值，窄化高频范围
        sleep_timer = 0; # 示例值，禁用休眠
      };

      # 输入设置 - 与示例一致
      input = {
        method = "pulse";
        source = "auto";
      };

      # 输出设置 - 保留 noncurses，示例倾向 ncurses
      output = {
        method = "noncurses"; # 性能优于 ncurses，接近示例
        channels = "stereo";
      };

      # 颜色设置 - Stylix 主题色
      color = {
        gradient = 1;
        gradient_count = 8;
        gradient_color_1 = "'#${colors.base0C}'"; # cyan
        gradient_color_2 = "'#${colors.base0B}'"; # green
        gradient_color_3 = "'#${colors.base0B}'"; # green
        gradient_color_4 = "'#${colors.base0A}'"; # yellow
        gradient_color_5 = "'#${colors.base09}'"; # orange
        gradient_color_6 = "'#${colors.base0E}'"; # magenta
        gradient_color_7 = "'#${colors.base0E}'"; # magenta
        gradient_color_8 = "'#${colors.base0D}'"; # blue
      };

      # 平滑设置 - 与示例对齐
      smoothing = {
        integral = 77; # 示例值，稍低平滑度
        monstercat = 0; # 示例值，禁用 Monstercat
        gravity = 100; # 示例值，下降较慢
        ignore = 0; # 一致
      };

      # 均衡器设置 - 保留你的轻微调整
      eq = {
        "1" = 1.2; # 低音增强
        "2" = 1.0;
        "3" = 1.0; # 中音默认
        "4" = 1.0;
        "5" = 1.1; # 高音提升
      };
    };
  };

}
