{ ... }: {

  flake.homeModules.waybar =

    { lib, config, ... }:

    {
      config = {
        programs.waybar.settings.mainBar."clock" = {
          tooltip-format = "{tz_list}";
          timezones = [
            "Asia/Tokyo"
            "Etc/UTC"
            "America/New_York"
            "Europe/Paris"
            "Asia/Manila"
          ];
          format = lib.concatStrings [
            ''<span weight="bold"> {0:%H:%M}</span>''
            ''<span size="small" rise="-1pt" color="${config.theme2.colors.green}" weight="bold"> {0:%Z}</span>''
          ];
        };
      };
    };
}
