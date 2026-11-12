{ ... }:

{
  imports = [ ./modules ];

  flake.homeModules.yubikey = { pkgs, ... }: {
    home.packages = [ pkgs.yubikey-manager ];
  };
}
