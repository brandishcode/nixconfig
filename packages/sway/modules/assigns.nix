{ ... }:

{
  flake.homeModules.swayNixos = { lib, config, ... }: {
    config = {
      wayland.windowManager.sway.config.assigns = {
        "0" = [
          (lib.mkIf config.programs.foot.enable {
            app_id = "foot";
          })
        ];
        "1" = [
          {
            app_id = "youtube";
          }
        ];
      };
    };
  };
}
