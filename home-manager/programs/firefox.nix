{ ... }:

{
  flake.homeModules.firefox = { pkgs, ... }: let
    profile = {
      bookmarks = {
        force = true;
        settings = [
          {
            name = "toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "ricing";
                bookmarks = [
                  {
                    name = "waybar wiki";
                    url = "https://github.com/Alexays/Waybar/wiki";
                  }
                ];
              }
              {
                name = "git";
                tags = [ "git" ];
                keyword = "git";
                url = "https://github.com/brandishcode?tab=repositories";
              }
              {
                name = "3D";
                bookmarks = [
                  {
                    name = "Projection Matrix";
                    url = "http://www.songho.ca/opengl/gl_projectionmatrix.html";
                  }
                  {
                    name = "Learn OpenGL";
                    url = "https://learnopengl.com/";
                  }
                  {
                    name = "Grid";
                    url = "https://asliceofrendering.com/scene%20helper/2020/01/05/InfiniteGrid/";
                  }
                ];
              }
              {
                name = "nix";
                bookmarks = [
                  {
                    name = "home-manager-options";
                    url = "https://nix-community.github.io/home-manager/options.xhtml";
                  }
                  {
                    name = "nix mkShell";
                    url = "https://ryantm.github.io/nixpkgs/builders/special/mkshell";
                  }
                  {
                    name = "nix makeWrapper";
                    url = "https://nixos.org/manual/nixpkgs/stable/#fun-makeWrapper";
                  }
                ];
              }
            ];
          }
        ];
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        tridactyl
      ];
      settings = {
        "browser.startup.homepage" = "https://github.com/brandishcode";
        "extensions.autoDisableScopes" = 0;
        "layout.css.prefers-color-scheme.content-override" = 1;
        "browser.cache.disk.enable" = false;
        "browser.cache.disk.smart_size.enabled" = false;
        "browser.cache.disk_cache_ssl" = false;
        "browser.cache.offline.enable" = false;
        "browser.cache.memory.enable" = true;
        "browser.cache.memory.capacity" = 1024000;
        "browser.theme.toolbar-theme" = 0;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.allow_transparent_browser" = true;
        "browser.aboutConfig.showWarning" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "identity.fxaccounts.toolbar.defaultVisible" = false;
        "extensions.pocket.enabled" = false;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "svg.context-properties.content.enabled" = true;
        "browser.sessionstore.resume_from_crash" = false;
        "signon.rememberSignons" = false;
        "services.sync.prefs.sync.signon.rememberSignons" = false;
      };
      search = {
        default = "ddg";
        order = [
          "ddg"
          "google"
        ];
        force = true;
      };
    };
    firefoxChrome = pkgs.callPackage ./cascadefox { inherit config; };
    searchEngines = {
      search.engines = {
        nix-packages = {
          name = "Nix packages";
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
              ];
            }
          ];
          definedAliases = [ "@nxp" ];
        };
        nix-options = {
          name = "Nix options";
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = [ "@nxo" ];
        };
        nixvim-docs = {
          name = "Nixvim docs";
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
          definedAliases = [ "@nxv" ];
        };
      };
    };
  in {
    home.packages = [ firefoxChrome ];
    home.file.".mozilla/firefox/default/chrome" = {
      source = "${firefoxChrome}/cascadefox/chrome";
      recursive = true;
    };
    home.file.".mozilla/firefox/youtube/chrome" = {
      source = "${firefoxChrome}/cascadefox/chrome";
      recursive = true;
    };
    home.file.".mozilla/firefox/netflix/chrome" = {
      source = "${firefoxChrome}/cascadefox/chrome";
      recursive = true;
    };
    programs.firefox = {
      enable = true;
      profiles = {
        default = pkgs.lib.mkMerge [
          profile
          searchEngines
        ];
        # default = profile // {
        #   userChrome = builtins.readFile ./userChrome.css;
        #   userContent = builtins.readFile ./userContent.css;
        # };
        youtube = {
          id = 1;
          isDefault = false;
        }
        // profile
        // {
          settings."layout.css.prefers-color-scheme.content-override" = 2;
        };
        netflix = {
          id = 2;
          isDefault = false;
        }
        // profile;
      };
    };
  };
}
