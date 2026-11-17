{
  home-manager-options = {
    name = "Home Manager";
    urls = [
      {
        template = "https://home-manager-options.extranix.com";
        params = [
          {
            name = "release";
            value = "master";
          }
          {
            name = "query";
            value = "{searchTerms}";
          }
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
          {
            name = "channel";
            value = "unstable";
          }
          {
            name = "query";
            value = "{searchTerms}";
          }
        ];
      }
    ];
    icon = "https://search.nixos.org/images/nixos-logomark-default-gradient-none.svg";
    definedAliases = [ "@nxp" ];
  };
  nixvim = {
    name = "Nixvim";
    urls = [
      {
        template = "https://nix-community.github.io/nixvim";
        params = [
          {
            name = "search";
            value = "{searchTerms}";
          }
        ];
      }
    ];
    ico = "https://nix-community.github.io/nixvim/favicon-de23e50b.svg";
    definedAliases = [ "@nxv" ];
  };
  flake-parts = {
    name = "Flake-parts";
    urls = [
      {
        template = "https://flake.parts";
        params = [
          {
            name = "search";
            value = "{searchTerms}";
          }
        ];
      }
    ];
    ico = "https://flake.parts/favicon-9f947651.svg";
    definedAliases = [ "@flkpt" ];
  };
}
