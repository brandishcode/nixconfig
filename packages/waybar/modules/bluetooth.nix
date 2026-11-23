{ ... }:

{
  flake.homeModules.waybar = { lib, config, ... }: {
    config = {
      programs.waybar.settings.mainBar."bluetooth" = {
        format = lib.concatStrings [
          ''<span size="large" color="${config.theme2.colors.green}" weight="bold"></span>''
          "<span> {status}</span>"
        ];
        format-disabled = "";
        format-connected = lib.concatStrings [
          ''<span size="large" color="${config.theme2.colors.green}"></span>''
          "<span> {num_connections} connected</span>"
        ];
        tooltip-format = "{controller_alias}\t{controller_address}";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        on-click = "rofi-bluetooth";
      };
    };
  };
}
