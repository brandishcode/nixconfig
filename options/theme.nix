{ ... }:

{
  flake.homeModules.theme = { lib, ... }: {
    options = {
      theme2 = {
        colors = lib.mkOption {
          default = {
            background = "";
            foreground = "";
            black = "";
            red = "";
            green = "";
            yellow = "";
            blue = "";
            magenta = "";
            cyan = "";
            white = "";
            brightblack = "";
            brightred = "";
            brightgreen = "";
            brightyellow = "";
            brightblue = "";
            brightmagenta = "";
            brightcyan = "";
            brightwhite = "";
          };
          type = lib.types.attrs;
          description = ''
            16-bit color scheme, with foreground and background
          '';
        };
      };
    };
  };
}
