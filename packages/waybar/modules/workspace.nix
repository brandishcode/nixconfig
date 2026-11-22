{ ... }:

{
  flake.homeModules.waybar =

    {
      programs.waybar.settings.mainBar."sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = ''<span size="x-large">{icon}</span>'';
        format-icons = {
          "0" = "󱝆 ";
          "1" = "󰗃 ";
          "2" = "󰌆";
          "9" = " ";
        };
      };
    };
}
