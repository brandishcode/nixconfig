# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, config, ... }:

{
  config = {
    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    # Bootloader.
    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking = {
      interfaces.enp3s0 = {
        ipv4.addresses = [
          {
            address = "172.22.1.120";
            prefixLength = 21;
          }
        ];
      };
      defaultGateway = {
        address = "172.22.0.1";
        interface = "enp3s0";
      };
      nameservers = [ "8.8.8.8" ];
    };

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Asia/Tokyo";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      "ko_KR.UTF-8/UTF-8"
      "ko_KR.EUC-KR/EUC-KR"
    ];

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    users.mutableUsers = false;
    users.groups = {
      development = { };
    };
    users.users.developer = {
      isNormalUser = true;
      description = "Developer user";
      extraGroups = [
        "development"
        "networkmanager"
        "wheel"
        "dialout"
        "audio"
      ];
      hashedPasswordFile = config.sops.secrets."users/developer".path;
    };
    users.users.root = {
      isSystemUser = true;
      hashedPasswordFile = config.sops.secrets."users/root".path;
    };

    # key mapping
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "henkan";
            };
          };
        };
      };
    };

    environment.variables = {
      # GTK_IM_MODULE = "fcitx";
      # QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      GLFW_IM_MODULE = "fcitx";
      XDG_CURRENT_DESKTOP = "sway";
    };

    services.xserver.desktopManager.runXdgAutostartIfNone = true;
    services.udev.packages = with pkgs; [
      vial
      via
    ];

    services.openssh = {
      enable = true;
    };
  };
}
