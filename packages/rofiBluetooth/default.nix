{ ... }:

{
  flake.homeModules.rofi-bluetooth =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      options = {
        programs.rofi-bluetooth = lib.mkOption {
          default = {
            enable = true;
            package = pkgs.rofi-bluetooth;
          };
          type = lib.types.attrs;
          description = ''
            Bluetooth manager
          '';
        };
      };

      config = {
        home.packages = lib.mkIf config.programs.rofi-bluetooth.enable [
          config.programs.rofi-bluetooth.package
        ];
      };
    };
}
