{ wallpaper }:

{
  monitor = [
    {
      output = "HDMI-A-2";
      inherit wallpaper;
      position = {
        x = 1920;
        y = 0;
      };
      transform = "normal";
    }
    {
      output = "DP-1";
      inherit wallpaper;
      position = {
        x = 0;
        y = 0;
      };
      transform = "normal";
    }
    {
      output = "HDMI-A-1";
      inherit wallpaper;
      position = {
        x = 3840;
        y = 145;
      };
      transform = "normal";
    }
  ];
}
