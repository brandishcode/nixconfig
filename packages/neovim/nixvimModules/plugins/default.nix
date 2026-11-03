{
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
}
