{ pkgs, ... }:
let
  colorScheme = rec {
    custom = true;
    name = "midnight";
    # 自定义方案: midnight
    # 内置方案(需改为 custom = false): catppuccin-mocha/frappe/latte/macchiato、
    # tokyo-night-moon、solarized-dark、rose-pine-moon、nord、darcula、
    # gruvbox-dark-medium、monokai、moonlight、kanagawa
    path =
      if custom then
        ./colorschemes/${name}.yaml
      else
        "${pkgs.base16-schemes}/share/themes/${name}.yaml";
    polarity = "dark";
  };
in
{
  stylix = {
    enable = true;
    enableReleaseChecks = false;
    autoEnable = false; # 选择性启用主题，只对明确配置的目标生效
    base16Scheme = colorScheme.path;
    polarity = colorScheme.polarity;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 13;
      };
    };

    targets = {
      kitty.enable = true;
      nixvim.enable = true;
      fuzzel.enable = true;
      noctalia-shell.enable = false; # 与自定义布局设置冲突
      starship.enable = false; # 使用自定义 toml 配置
      hyprlock.enable = false; # 手动配置更灵活
    };
  };
}
