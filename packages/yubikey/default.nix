{ ... }:

{
  imports = [ ./modules ];

  flake.homeModules.yubikey = { pkgs, ... }: {
    home.packages = with pkgs; [ yubikey-manager yubikey-personalization ];
  };
}
