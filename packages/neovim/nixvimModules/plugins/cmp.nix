{
  plugins = {
    cmp-nvim-lsp.enable = true;
    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        sources = [ { name = "nvim_lsp"; } ];
      };
    };
  };
}
