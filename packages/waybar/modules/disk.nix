{ ... }:
{
  flake.homeModules.waybar =

    { config, lib, ... }:

    let
      createFormat =
        icon: color:
        lib.concatStrings [
          ''<span size="large" color="${color}">${icon}</span>''
          "<span>{free}</span>"
        ];
      interval = 60;
    in
    {
      config = {
        programs.waybar.settings.mainBar = {
          "disk#home" = {
            inherit interval;
            format = createFormat "󰋜 " config.theme2.colors.green;
            path = "/home";
          };
          "disk#development" = {
            inherit interval;
            format = createFormat " " config.theme2.colors.green;
            path = "/development";
          };
          "disk#documents" = {
            inherit interval;
            format = createFormat "󰈙 " config.theme2.colors.green;
            path = "/documents";
          };
          "disk#root" = {
            inherit interval;
            format = createFormat " " config.theme2.colors.green;
          };
        };
      };
    };
}
