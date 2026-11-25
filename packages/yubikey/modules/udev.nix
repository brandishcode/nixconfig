{ ... }:

{
  flake.nixosModules.yubikey = { pkgs, ... }: {
    security.pam.services = {
      login.u2f.enable = true;
      sudo.u2f.enable = true;
    };
    services.udev.packages = [ pkgs.yubikey-personalization ];

    security.pam.yubico = {
      enable = true;
      debug = true;
      mode = "challenge-response";
    };
  };
}
