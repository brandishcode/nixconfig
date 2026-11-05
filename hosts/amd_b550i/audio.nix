{ ... }:

{
  flake.nixosModules.amd_b550i = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cdrtools
      alsa-utils
      pulseaudio
    ];
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    services.mpd = {
      enable = true;
      musicDirectory = "/documents/nixos/music";
      network.listenAddress = "any";
      user = "developer";
      # settings = ''
      #   audio_output {
      #     type "pipewire"
      #     name "My pipewire output"
      #   }
      # '';
    };
    systemd.services.mpd.environment = {
      # must match the services.mpd.user UID
      XDG_RUNTIME_DIR = "/run/user/1000";
    };
  };
}
