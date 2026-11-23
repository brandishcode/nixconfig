{ ... }:

{
  flake.nixosModules.swayNixos = { lib, config, ... }: {
    config = {
      security.polkit.enable = lib.mkIf config.home-manager.users.developer.wayland.windowManager.sway.enable true;
    };
  };
}
