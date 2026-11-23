{ ... }:

{
  flake.homeModules.theme-tokyonight = { lib, ... }: {
    theme2.name = "tokyonight";
    theme2.backgrounds.tokyonight = ../wallpapers/tokyo_night_00.jpg;
    theme2.colors = lib.mkDefault {
      background = "#1a1b26";
      foreground = "#c0caf5";
      black = "#414868";
      red = "#f7768e";
      green = "#9ece6a";
      yellow = "#e0af68";
      blue = "#7aa2f7";
      magenta = "#bb9af7";
      cyan = "#7dcfff";
      white = "#a9b1d6";
      brightblack = "#414868";
      brightred = "#f7768e";
      brightgreen = "#9ece6a";
      brightyellow = "#e0af68";
      brightblue = "#7aa2f7";
      brightmagenta = "#bb9af7";
      brightcyan = "#7dcfff";
      brightwhite = "#c0caf5";
    };
  };
}
