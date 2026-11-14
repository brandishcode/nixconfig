{ ... }:

{
  flake.homeModules.librewolf = { ... }: {
    programs.librewolf.profiles.search-engine = {
      id = 0;
      bookmarks = {
        force = true;
        settings = [
          {
            name = "github";
            tags = [ "git" ];
            keyword = "gh";
            url = "https://github.com/brandishcode";
          }
        ];
      };
      search = {
        force = true;
        engines = {
          home-manager-options = {  
            name = "Home Manager - Options";
            urls = [
              {
                template = "https://home-manager-options.extranix.com";
                params = [
                  { name = "release"; value = "master"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }
            ];
            icon = "https://home-manager-options.extranix.com/images/favicon.png";
            definedAliases = [ "@hmo" ];
          };
          nixos-packages = {
            name = "Nixos Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "channel"; value = "unstable"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }
            ];
            icon = "https://search.nixos.org/images/nixos-logomark-default-gradient-none.svg";
            definedAliases = [ "@nxp" ];
          };
        };
      };
      settings = {
        "browser.startup.homepage" = "https://github.com";
        "layout.css.prefers-color-scheme.content-override" = 0;
      };
    };
  };
}
