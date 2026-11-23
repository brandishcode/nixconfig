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
              "bluetooth"
              "clock#calendar"
              "clock"
            ];
          };
        };
        style = pkgs.replaceVars ./style.css {
          foreground = config.theme2.colors.foreground;
          green = config.theme2.colors.green;
          magenta = config.theme2.colors.magenta;
          red = config.theme2.colors.red;
        };
      };
    };
  };
}
