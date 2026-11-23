{ ... }:

{
  imports = [ ./modules ];
  flake.homeModules.swayNixos =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      config = {
        home.packages = with pkgs; [
          wl-clipboard
          swaybg
        ];
        programs.swaylock.enable = true;
        wayland.windowManager.sway = {
          enable = true;
          config =
            let
              modifier = "Mod4";
            in
            {
              terminal = lib.mkIf config.programs.foot.enable "foot";
              menu = "rofi -show drun";
              startup = [
                { command = "fcitx5"; }
                {
                  command = lib.mkIf config.programs.foot.enable "--no-startup-id swaymsg 'workspace 0; exec foot --app-id main-foot'";
                }
                {
                  command = ''--no-startup-id swaymsg "workspace 1; exec librewolf --name youtube -P youtube --no-remote"'';
                }
                {
                  command = ''--no-startup-id swaymsg "workspace 9; exec librewolf --name search-engine -P search-engine --no-remote"'';
                }
              ];
              window.commands = [
                (lib.mkIf config.programs.foot.enable {
                  command = "floating enable, resize set 75 ppt 75 ppt";
                  criteria = {
                    title = "File Explorer";
                    app_id = "foot-ranger";
                  };
                })
              ];
              bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];
              gaps.outer = 2;
              output =
                let
                  bg = "${../../staticAssets/wallpaper/tokyo_night_00.jpg} fill";
                in
                {
                  "DP-1" = {
                    position = "0,0";
                    inherit bg;
                  };
                  "HDMI-A-1" = {
                    position = "3840,145";
                    inherit bg;
                  };
                  "HDMI-A-2" = {
                    position = "1920,0";
                    inherit bg;
                  };
                };
              workspaceOutputAssign = [
                {
                  workspace = "0";
                  output = "HDMI-A-1";
                }
                {
                  workspace = "1";
                  output = "DP-1";
                }
                {
                  workspace = "2";
                  output = "HDMI-A-2";
                }
                {
                  workspace = "9";
                  output = "HDMI-A-2";
                }
              ];
              modifier = "Mod4";
              keybindings = lib.mkOptionDefault {
                "${modifier}+Shift+e" =
                  lib.mkIf config.programs.foot.enable "exec foot --app-id foot-ranger -T 'File Explorer' ranger";
                "${modifier}+Shift+b" = "exec librewolf --name search-engine -P search-engine";
                "${modifier}+Shift+y" = "exec librewolf --name youtube -P youtube";
                "${modifier}+Control+Shift+a" = "move workspace to output DP-1";
                "${modifier}+Control+Shift+o" = "move workspace to output HDMI-A-2";
                "${modifier}+Control+Shift+e" = "move workspace to output HDMI-A-1";
                "${modifier}+0" = "workspace 0";
                "${modifier}+1" = "workspace 1";
                "${modifier}+2" = "workspace 2";
                "${modifier}+9" = "workspace 9";
                "${modifier}+Shift+0" = "move window to workspace 0";
                "${modifier}+Shift+1" = "move window to workspace 1";
                "${modifier}+Shift+2" = "move window to workspace 2";
                "${modifier}+Shift+9" = "move window to workspace 9";
              };
              colors =
                let
                  background = "#1a1b26" + "00";
                  urgentBackground = "#f7768e" + "CC";
                  border = background;
                  indicator = background;
                  childBorder = background;
                in
                {
                  focused = {
                    inherit border;
                    inherit background;
                    text = "#bb9af7";
                    inherit indicator;
                    inherit childBorder;
                  };
                  focusedInactive = {
                    inherit border;
                    inherit background;
                    text = "#7dcfff";
                    inherit indicator;
                    inherit childBorder;
                  };
                  unfocused = {
                    inherit border;
                    inherit background;
                    text = "#9ece6a";
                    inherit indicator;
                    inherit childBorder;
                  };
                  urgent = {
                    inherit border;
                    background = urgentBackground;
                    text = "#c0caf5";
                    inherit indicator;
                    inherit childBorder;
                  };
                };
            };
        };
      };
    };
}
