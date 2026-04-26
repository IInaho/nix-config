# nixvim - Nix 管理的 Neovim 配置
{ pkgs, lib, ... }:

{
  programs.nixvim = {
    enable = true;

    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    # Leader key
    leader = " ";

    # Options
    opts = {
      number = lib.mkDefault true;
      relativenumber = lib.mkDefault true;
      mouse = "a";
      clipboard = "unnamedplus";
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
    };

    # Keymaps
    keymaps = import ./keymaps.nix;

    # Plugins
    plugins = {
      web-devicons.enable = true;
      tokyonight = {
        enable = true;
        style = "night";
      };
      startupify.enable = true;
      neo-tree.enable = true;
      vim-surround.enable = true;
      nvim-cmp.enable = true;
      gitsigns.enable = true;
      telescope.enable = true;
      treesitter = {
        enable = true;
        ensureInstalled = [
          "lua"
          "bash"
          "python"
          "vim"
          "vimdoc"
        ];
        highlight = {
          enable = true;
        };
        indent = {
          enable = false;
        };
      };
      lsp.enable = true;
    };
  };
}
