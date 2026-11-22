{ ... }:

{
  imports = [ ./modules ];

  flake.homeModules.waybar = { pkgs, config, ... }: {
    config = {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "bottom";
            height = 35;
            output = [
              "DP-1"
              "HDMI-A-2"
              "HDMI-A-1"
            ];
            modules-left = [
              "tray"
              "pulseaudio"
            ];
            modules-center = [
              "sway/mode"
              "sway/workspaces"
            ];
            modules-right = [
              "disk#root"
              "disk#home"
              "disk#development"
              "disk#documents"
              "memory"
              "network"
              "clock#calendar"
              "clock"
            ];
          };
        };
        style = pkgs.replaceVars ./style.css {
          foreground = config.theme.colors.foreground;
          green = config.theme.colors.green;
          magenta = config.theme.colors.magenta;
          red = config.theme.colors.red;
        };
      };
    };
  };
}
