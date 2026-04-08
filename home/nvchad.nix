{ config, pkgs, ... }:
{
  programs.nvchad = {
    enable = true;
    hm-activation = true;
    backup = false;

    extraConfig = ''
      vim.opt.number = true
      vim.opt.relativenumber = true
    '';
  };
}
