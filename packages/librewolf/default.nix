{ ... }:

{
  imports = [ ./modules ];

  flake.homeModules.librewolf = { config, ... }: {
    programs.librewolf = {
      enable = true;
      languagePacks = [
        "en-US"
        "ja-JP"
      ];
      policies = {
        DefaultDownloadDirectory = "${config.home.homeDirectory}";
        ExtensionSettings = {
          "tridactyl.vim@cmcaine.co.uk" = {
            installation_mode = "normal_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl.vim@cmcaine.co.uk/latest.xpi";
          };
          "keepassxc-browser@keepassxc.org" = {
            default_area = "navbar";
            installation_mode = "normal_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser@keepassxc.org/latest.xpi";
          };
        };
      };
    };
  };
}
