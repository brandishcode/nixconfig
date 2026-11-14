{ ... }:

{
  flake.homeModules.librewolf = { ... }: {
    programs.librewolf.profiles.youtube = {
      id = 1;
      settings = {
        "browser.startup.homepage" = "https://www.youtube.com";
      };
    };
  };
}
