{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./secrets.nix
  ];

  home.packages = with pkgs; [
    xdg-utils
  ];

  xdg = {
    enable = true;
    userDirs.enable = false;
  };

  programs.bash = {
    enable = true;
    historyFile = "${config.xdg.stateHome}/bash/history";
  };

  home.sessionVariables = {
    GOPATH = "${config.xdg.dataHome}/go";
    PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    WGETRC = "${config.xdg.configHome}/wget/wgetrc";
    LESSHISTFILE = "${config.xdg.stateHome}/less/history";
    VIM = "${config.xdg.configHome}/vim";
    VIMINIT = "set viminfo='100,n${config.xdg.stateHome}/vim/viminfo' | source $VIM/vimrc";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
  };
}
