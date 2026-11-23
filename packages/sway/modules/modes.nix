{ ... }:

{
  flake.homeModules.swayNixos = { lib, config, ... }: {
    config = {
      wayland.windowManager.sway.extraConfigEarly = ''
        set $media_launcher Launch: [l]ibrewolf [v]lc
      '';
      wayland.windowManager.sway.config = {
        keybindings =
          let
            modifier = "${config.wayland.windowManager.sway.config.modifier}";
          in
          lib.mkOptionDefault {
            "${modifier}+a" = "mode \"$media_launcher\"";
          };
        modes = {
          "$media_launcher" = {
            "l" = "exec librewolf --name youtube -P youtube; mode default";
            "v" = "exec vlc; mode default";
            "Escape" = "mode default";
            "Return" = "mode default";
          };
        };
      };
    };
  };
}
