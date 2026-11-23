{ ... }:

{
  flake.nixosModules.sddm =
    {
      pkgs,
      config,
      ...
    }:

    {
      config = {
        # SDDM ,and DesktopManager setup
        environment.sessionVariables = {
          WLR_NO_HARDWARE_CURSORS = "1";
          NIXOS_OZONE_WL = "1";
        };

        services.displayManager = {
          defaultSession = "sway";
          sessionPackages = [ pkgs.sway ];
          sddm = {
            theme = "sddm-astronaut-theme";
            enable = true;
            wayland.enable = true;
            package = pkgs.kdePackages.sddm;
            extraPackages = [ pkgs.kdePackages.qtmultimedia ];
          };
        };
        environment.systemPackages = [
          (pkgs.sddm-astronaut.override {
            themeConfig = {
              Background = "${config.home-manager.users.developer.theme2.backgrounds.tokyonight}";
              FormPosition = "left";
            };
          })
        ];
      };
    };
}
