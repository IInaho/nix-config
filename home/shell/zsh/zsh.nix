{ config, pkgs, ... }:

let
  p10k-theme = pkgs.zsh-powerlevel10k;
in
{
  home.packages = [ p10k-theme ];

  home.shell.enableZshIntegration = true;

  xdg.configFile."zsh/p10k.zsh".source = ./p10k.zsh;

  programs.zsh = {
    enable = true;
    history.path = "${config.xdg.stateHome}/zsh/history";
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${config.xdg.configHome}/zsh/p10k.zsh
      ZSH_COMPDUMP="${config.xdg.cacheHome}/zsh/zcompdump-''${ZSH_VERSION}"
    '';
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };
}
