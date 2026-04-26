{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.stateVersion = "26.05";

  imports = [
    ./base/fcitx5.nix
    ./base/secrets.nix
    ./desktop/niri/default.nix
    ./desktop/noctalia/default.nix
    ./desktop/hyprlock/default.nix
    ./desktop/fuzzel.nix
    ./desktop/kitty.nix
    ./desktop/gtk.nix
    ./shell/default.nix
    ./xdg/default.nix
    ./xdg/mime.nix
    ./xdg/autostart.nix
    ./xdg/desktop-files.nix
    ./programs/ai.nix
    ./programs/apps.nix
    ./programs/asciinema.nix
    ./programs/btm.nix
    ./programs/cava.nix
    ./programs/devtools.nix
    ./programs/fastfetch.nix
    ./programs/git.nix
    ./programs/nh.nix
    ./programs/nixvim.nix
    ./programs/system-tui.nix
  ];

  home.packages = with pkgs; [
    gifski
    ffmpeg
    openssl

    net-tools
    translate-shell
    libcaca
    yq
    jq
    unzip
    duf
    iotop
    cloc
    doggo
    dive
    lsof
    wget

    tree
    fd
    ripgrep
    bat
    chafa
    yazi
    tmux
    sops
    nixfmt-tree
    just
    fzf
    lazygit
    hugo
  ];
}
