{ ... }:

{
  flake.nixosModules.yubikey = { pkgs, config, ... }: {
    services.udev.packages = [ pkgs.yubikey-personalization ];

    security.pam.yubico = {
      enable = false;
      debug = true;
      mode = "challenge-response";
      id = [ config.sops.secrets."yubikey/id" ];
    };
  };
}
