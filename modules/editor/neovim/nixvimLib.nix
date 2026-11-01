toplevel@{ inputs, ... }:
{
  flake.lib = inputs.nixvim.lib;
  perSystem = { ... }: {
    _module.args.nixvimLib = toplevel.config.flake.lib;
  };
}
