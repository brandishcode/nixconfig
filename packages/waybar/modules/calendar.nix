{ ... }:
{
  flake.homeModules.waybar =

    { lib, config, ... }:

    {
      config = {
        programs.waybar.settings.mainBar."clock#calendar" = {
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          format = lib.concatStrings [
            ''<span size="large" color="${config.theme2.colors.green}" weight="bold"> </span>''
            "<span> {0:%Y/%m/%d}</span>"
          ];
          calendar = {
            mode = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            format = {
              months = ''<span color="${config.theme2.colors.white}"><b>{}</b></span>'';
              days = ''<span color="${config.theme2.colors.white}"><b>{}</b></span>'';
              weeks = ''<span color="${config.theme2.colors.green}"><b>W{}</b></span>'';
              weekdays = ''<span color="${config.theme2.colors.yellow}"><b>{}</b></span>'';
              today = ''<span color="${config.theme2.colors.red}"><b><u>{}</u></b></span>'';
            };
          };
        };
      };
    };
}
