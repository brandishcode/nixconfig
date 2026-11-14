{ ... }:

{
  flake.homeModules.keepassxc = { config, ... }: {
    programs.keepassxc = {
      autostart = true;
      enable = true;
      settings = {
        FdoSecrets.Enabled = true;
        Browser.Enabled = true;
        Browser.UseCustomBrowser = true;
        Browser.CustomBrowserType = "Firefox";
        Browser.CustomBrowserLocation = "${config.home.homeDirectory}/.librewolf/native-messaging-hosts";
        Browser.UpdateBinaryPath = false;
        Security.IconDownloadFallback = true;
      };
    };
  };
}
