{ ... }:

{
  flake.homeModules.librewolf =
    { ... }:
    let
      commonSettings = import ./common/settings.nix;
      searchEngineNixDocs = import ./searchEngines/nixDocs.nix;
      bookmarks = import ./bookmarks/nixBookmarks.nix;
    in
    {
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
          ]
          ++ bookmarks;
        };
        search = {
          force = true;
          engines = { } // searchEngineNixDocs;
        };
        settings = {
          "browser.startup.homepage" = "about:blank";
        }
        // commonSettings;
      };
    };
}
