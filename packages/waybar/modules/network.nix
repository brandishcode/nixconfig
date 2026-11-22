{ ... }:
{

  flake.homeModules.waybar =
    { lib, config, ... }:

    let
      createFormat =
        icon: color:
        lib.concatStrings [
          ''<span size="large" color="${color}">${icon} </span>''
          "{ifname}"
        ];
    in
    {
      config = {
        programs.waybar.settings.mainBar.network = {
          format-wifi = createFormat "󰖩 " config.theme.colors.green;
          format-ethernet = createFormat "󰈀 " config.theme.colors.green;
          tooltip-format-ethernet = lib.concatStrings [ "{ipaddr}" ];
        };
      };
    };
}
