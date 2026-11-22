{ ... }:

{
  flake.homeModules.fastfetch = {
    programs.fastfetch = {
      enable = true;
      settings = {
        modules = [
          "os"
          "host"
          "kernel"
          "lm"
          "wm"
          "terminal"
          "shell"
          "editor"
        ];
      };
    };
  };
}
