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
            lib.mkMerge [
              {
                menu = "rofi -show drun";
                startup = [
                  { command = "fcitx5"; }
                  {
                    command = ''--no-startup-id swaymsg "workspace 1; exec librewolf --name youtube -P youtube --no-remote"'';
                  }
                  {
                    command = ''--no-startup-id swaymsg "workspace 9; exec librewolf --name search-engine -P search-engine --no-remote"'';
                  }
                ];
                bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];
                gaps.outer = 2;
                output =
                  let
                    bg = lib.mkIf (config.theme2.name == "tokyonight") "${config.theme2.backgrounds.tokyonight} fill";
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
                inherit modifier;
                keybindings = lib.mkOptionDefault {
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
                    background = config.theme2.colors.background + "00";
                    urgentBackground = config.theme2.colors.red + "CC";
                    border = background;
                    indicator = background;
                    childBorder = background;
                  in
                  {
                    focused = {
                      inherit border;
                      inherit background;
                      text = config.theme2.colors.magenta;
                      inherit indicator;
                      inherit childBorder;
                    };
                    focusedInactive = {
                      inherit border;
                      inherit background;
                      text = config.theme2.colors.cyan;
                      inherit indicator;
                      inherit childBorder;
                    };
                    unfocused = {
                      inherit border;
                      inherit background;
                      text = config.theme2.colors.green;
                      inherit indicator;
                      inherit childBorder;
                    };
                    urgent = {
                      inherit border;
                      background = urgentBackground;
                      text = config.theme2.colors.foreground;
                      inherit indicator;
                      inherit childBorder;
                    };
                  };
              }
              (lib.mkIf config.programs.foot.enable {
                terminal = "foot";
                startup = [
                  {
                    command = "--no-startup-id swaymsg 'workspace 0; exec foot --app-id main-foot'";
                  }

                ];
                keybindings = lib.mkOptionDefault {
                  "${modifier}+Shift+e" = "exec foot --app-id foot-ranger -T 'File Explorer' ranger";

                };
                window.commands = [
                  {
                    command = "floating enable, resize set 75 ppt 75 ppt";
                    criteria = {
                      title = "File Explorer";
                      app_id = "foot-ranger";
                    };
                  }
                ];
              })
            ];
        };
      };
    };
}
