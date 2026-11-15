{ ... }:

{
  flake.homeModules.librewolf = { ... }: 
  let
    commonSettings = import ./common/settings.nix;
  in {
    programs.librewolf.profiles.youtube = {
      id = 1;
      settings = {
        "browser.startup.homepage" = "https://www.youtube.com";
      } // commonSettings;
    };
  };
}
