toplevel@{ inputs, ... }:
{
  flake.lib = {
    nixvim = inputs.nixvim.lib;
  };
  perSystem = { ... }: {
    _module.args.nixvimLib = toplevel.config.flake.lib.nixvim;
  };
}
