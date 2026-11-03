{ ... }:

{
  flake.modules.nixvim.base-config = {
    viAlias = true;
    vimAlias = true;

    #theming
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "night";
      };
    };

    opts = {
      number = true;
      relativenumber = true;

      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      expandtab = true;
      smarttab = true;

      scrolloff = 8;
      colorcolumn = "80";
      hlsearch = false;
      termguicolors = false;
    };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        mode = "i";
        action = "<Esc>";
        key = "jj";
      }
      {
        mode = "n";
        action = "<Nop>";
        key = "<Space>";
      }
      {
        mode = "n";
        action = "o<Esc>";
        key = "o";
      }
      {
        mode = "n";
        action = "O<Esc>";
        key = "O";
      }
      {
        mode = "n";
        action = "<Cmd>Explore<Cr>";
        key = "<Leader>w";
      }
      {
        mode = "n";
        action = "<Cmd>lua vim.diagnostic.open_float()<Cr>";
        key = "<Leader>vd";
      }
      {
        mode = "n";
        action = "<Cmd>Neorg index<Cr>";
        key = "<Leader>ni";
      }
    ];

    plugins = {
      web-devicons.enable = true;
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          marksman.enable = true;
        };
      };
      colorizer.enable = true;
      transparent.enable = true;
    };
  };
}
