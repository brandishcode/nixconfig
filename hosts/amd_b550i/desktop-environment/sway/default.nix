{
  pkgs,
  config,
  lib,
  ...
}:

{
  config = lib.mkIf (config.desktopEnvironment.sway) {
    security.polkit.enable = true;
    home-manager.users.developer = {
      imports = [
        ./display.nix
        ./keybinding.nix
        ./swayidle.nix
        ./swaylock.nix
      ];
      home = {
        packages = with pkgs; [
          wl-clipboard
          swaybg
        ];
      };
      wayland.windowManager.sway =
        let
          workspaceIcons = config.theme.icons;
        in
        {
          enable = true;
          config = {
            # assigns = {
            #   "${workspaceIcons.browser}" = [{ app_id = "^firefox$"; }];
            #   "${workspaceIcons.terminal}" = [{ app_id = "^foot$"; }];
            #   "${workspaceIcons.devBrowser}" =
            #     [{ app_id = "^chromium-browser$"; }];
            # };
            startup = [
              { command = "fcitx5"; }
              {
                command = "--no-startup-id swaymsg 'workspace 0; exec foot --app-id main-foot'";
              }
              {
                command = ''--no-startup-id swaymsg "workspace 1; exec librewolf --name youtube -P youtube --no-remote"'';
              }
              {
                command = ''--no-startup-id swaymsg "workspace 9; exec librewolf --name search-engine -P search-engine --no-remote"'';
              }
            ];
            window = {
              commands = [
                {
                  command = "floating enable, resize set 75 ppt 75 ppt";
                  criteria = {
                    title = "File Explorer";
                    app_id = "foot-ranger";
                  };
                }
              ];
            };
            terminal = "foot";
            menu = "rofi -show drun";
            colors = (import ./theme.nix { inherit config; });
            bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];
            gaps.outer = 2;
          };
          # extraConfig = ''
          #   default_border none
          # '';
        };
    };
  };
}
