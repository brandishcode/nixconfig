{ ... }:

{
  flake.modules.nixvim.plugin-lsp-tsc = {
    plugins = {
      lsp.enable = true;
      lsp.servers = {
        tsc.enable = true;
      };
    };
  };
}
