{ ... }:

{
  flake.homeModules.waybar =
    { config, lib, ... }:
    {
      config = {
        programs.waybar.settings.mainBar.memory = {
          interval = 60;
          tooltip-format = "{used:0.1f} used out of {total:0.1f} ({percentage}%)";
          format = lib.concatStrings [
            ''<span size="large" color="${config.theme2.colors.green}"> </span>''
            "<span> {used:0.1f}G</span>"
          ];
        };
      };
    };
}
