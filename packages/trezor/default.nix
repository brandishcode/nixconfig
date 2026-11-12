{ ... }:

{
  flake.homeModules.trezor = { pkgs, ... }: {
    home.packages = [ pkgs.trezor-suite ];
  };
}
