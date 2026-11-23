{
  self,
  withSystem,
  inputs,
  ...
}:

let
  nixPkgsConfig = {
    nixpkgs.overlays = [
      inputs.nur.overlays.default
    ];
    nixpkgs.config.allowUnfree = true;
  };
in
{
  flake.homeModules.developer = { pkgs, ... }: {
    home.homeDirectory = "/home/developer";
    home.username = "developer";
    home.stateVersion = "26.11";
    programs = {
      home-manager.enable = true;
      direnv = {
        enable = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };
    };
    xdg.autostart.enable = true;
    imports = [
      inputs.sops-nix.homeManagerModules.sops
      self.homeModules.theme
      self.homeModules.theme-tokyonight
      self.homeModules.calibre
      self.homeModules.trezor
      self.homeModules.yubikey
      self.homeModules.librewolf
      self.homeModules.keepassxc
      self.homeModules.ranger
      self.homeModules.bash
      self.homeModules.tmux
      self.homeModules.fastfetch
      self.homeModules.swayNixos
      self.homeModules.waybar
      self.homeModules.rofi
      self.homeModules.rofi-bluetooth
      self.homeModules.foot
      self.homeModules.neovim
      ./packages
      {
        config = {
          sops.defaultSopsFile = ./secrets/homemanager.yaml;
          sops.defaultSopsFormat = "yaml";
          sops.age.keyFile = "/home/developer/.config/sops/age/keys.txt";
          sops.secrets."git_token/public_repo" = { };
          sops.secrets."git/email" = { };
          sops.secrets."git/name" = { };
        };
      }
      {
        home.packages = with pkgs; [
          qbittorrent
          lutris
          vlc
        ];
      }
    ];
  };

  flake.homeConfigurations.developer = withSystem "x86_64-linux" (
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        nixPkgsConfig
        self.homeModules.developer
      ];
    }
  );

  flake.nixosConfigurations.B550I-AORUS-PRO-AX-rev-12 = withSystem "x86_64-linux" (
    { pkgs, ... }:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        nixPkgsConfig
        ({ modulesPath, ... }: {
          imports = [
            (modulesPath + "/installer/scan/not-detected.nix")
          ];
          system.stateVersion = "26.11";
          nix.settings.bash-prompt-prefix = "\\[\\033[43m\\]\\[\\033[1;30m\\](nix-develop)";
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];
          nixpkgs.hostPlatform = "x86_64-linux";
          environment.systemPackages = with pkgs; [ wireguard-tools ];
          networking.firewall.enable = false;
          networking.firewall.checkReversePath = false;
        })
        self.nixosModules.B550I-AORUS-PRO-AX-rev-12
        self.nixosModules.calibre
        self.nixosModules.yubikey
        self.nixosModules.swayNixos
        self.nixosModules.sddm
        ./sops.nix
        ./system
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.developer = self.homeModules.developer;
        }
        {
          security.pam.services.swaylock = {
            text = ''
              auth include login
            '';
          };
          services.pcscd.enable = true;
          programs.dconf.enable = true;
        }
      ];
    }
  );

  imports = [
    ./boot.nix
    ./graphics.nix
    ./fileSystems.nix
    ./audio.nix
    ./vpn.nix
  ];
}
