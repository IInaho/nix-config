# Nixvim keymaps
[
  {
    key = "<Space>w";
    action = ":w<CR>";
    options = {
      silent = true;
    };
  }
  {
    key = "<Space>q";
    action = ":q<CR>";
    options = {
      silent = true;
    };
  }
  {
    key = "<Space>e";
    action = ":Neotree toggle<CR>";
    options = {
      silent = true;
    };
  }
  {
    key = "<Space>ff";
    action = "Telescope find_files<CR>";
    options = {
      silent = true;
    };
  }
  {
    key = "<Space>fg";
    action = "Telescope live_grep<CR>";
    options = {
      silent = true;
    };
  }
  {
    key = "<Space>fb";
    action = "Telescope buffers<CR>";
    options = {
      silent = true;
    };
  }
  {
    key = "<Space>fh";
    action = "Telescope help_tags<CR>";
    options = {
      silent = true;
    };
  }
  {
    key = "jk";
    action = "<Esc>";
    options = {
      silent = true;
    };
  }
  # Window navigation
  {
    mode = "n";
    key = "<C-h>";
    action = "<C-w>h";
    options = {
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<C-j>";
    action = "<C-w>j";
    options = {
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<C-k>";
    action = "<C-w>k";
    options = {
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<C-l>";
    action = "<C-w>l";
    options = {
      silent = true;
    };
  }
  # Visual mode: move selected lines down
  {
    mode = "v";
    key = "J";
    action = ":m '>+1<CR>gv=gv";
    options = {
      silent = true;
      desc = "Move selected lines down";
    };
  }
  # Visual mode: move selected lines up
  {
    mode = "v";
    key = "K";
    action = ":m '<-2<CR>gv=gv";
    options = {
      silent = true;
      desc = "Move selected lines up";
    };
  }
  # Visual mode: indent right
  {
    mode = "v";
    key = ">";
    action = ">gv";
    options = {
      silent = true;
      desc = "Indent right and reselect";
    };
  }
  # Visual mode: indent left
  {
    mode = "v";
    key = "<";
    action = "<gv";
    options = {
      silent = true;
      desc = "Indent left and reselect";
    };
  }
]
