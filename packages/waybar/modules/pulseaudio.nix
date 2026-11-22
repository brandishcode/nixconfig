{ ... }:
{

  flake.homeModules.waybar =
    { config, lib, ... }:
    {

      config = {
        programs.waybar.settings.mainBar.pulseaudio = {
          format = lib.concatStrings [
            ''<span size="large" color="${config.theme2.colors.magenta}">{icon}</span>''
            "<span> {volume}%</span>"
          ];
          format-icons = {
            "alsa_output.pci-0000_06_00.1.hdmi-stereo-extra1" = "󰽟 ";
            "bluez_output.14_3F_A6_7C_E6_9C.1" = " ";
          };
        };
      };
    };
}
