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
    opt = {
      number = lib.mkDefault true;
      relativenumber = lib.mkDefault true;
      mouse = "a";
      clipboard = "unnamedplus";
      tabstop = 4;
      shiftwidth = 4;
      expandTab = true;
    };

     # Keymaps
    keymaps = [
      {
        key = "<Space>w";
        action = ":w<CR>";
        options = { silent = true; };
      }
      {
        key = "<Space>q";
        action = ":q<CR>";
        options = { silent = true; };
      }
      {
        key = "<Space>e";
        action = ":Neotree toggle<CR>";
        options = { silent = true; };
      }
      {
        key = "<Space>ff";
        action = "Telescope find_files<CR>";
        options = { silent = true; };
      }
      {
        key = "<Space>fg";
        action = "Telescope live_grep<CR>";
        options = { silent = true; };
      }
      {
        key = "<Space>fb";
        action = "Telescope buffers<CR>";
        options = { silent = true; };
      }
      {
        key = "<Space>fh";
        action = "Telescope help_tags<CR>";
        options = { silent = true; };
      }
      {
        key = "jk";
        action = "<Esc>";
        options = { silent = true; };
      }
      # Window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = { silent = true; };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = { silent = true; };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = { silent = true; };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = { silent = true; };
      }
    ];

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
         ensureInstalled = [ "lua" "bash" "python" "vim" "vimdoc" ];
         highlight = {
           enable = true;
         };
         indent = {
           enable = false;
         };
       };
      lsp.enable = true;
    };

    # 自动重新加载外部修改的文件
    extraConfigVim = ''
      autocmd FocusGained * checktime
      autocmd FileChangedShellPost * edit
    '';
  };
}
