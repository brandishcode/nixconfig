{ ... }:

{
  flake.modules.nixvim.plugin-lsp-ts_ls = {
    plugins = {
      lsp.enable = true;
      lsp.servers = {
        ts_ls.enable = true;
      };
    };
  };
}
