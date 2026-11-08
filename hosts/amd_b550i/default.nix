{ self, withSystem, inputs , ... }:

let
  nixPkgsConfig = {
    nixpkgs.overlays = [
      inputs.nur.overlays.default
    ];
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.problems.handlers = {
      "gtk+".broken = "warn"; # or "ignore"
    };
  };
in
{
  flake.homeModules.developer = { pkgs, ... }: {
    home.homeDirectory = "/home/developer";
    home.username = "developer";
    home.stateVersion = "25.05";
    programs = {
      home-manager.enable = true;
      direnv = {
        enable = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };
    };
    programs.keepassxc = {
      autostart = true;
      enable = true;
      settings = {
        FdoSecrets.Enabled = true;
      };
    };
    xdg.autostart.enable = true;
    imports = [
      inputs.sops-nix.homeManagerModules.sops
      self.homeModules.calibre
      ./packages
      {
        config = {
          sops.defaultSopsFile = ./secrets/homemanager.yaml;
          sops.defaultSopsFormat = "yaml";
          sops.age.keyFile = "/home/developer/.config/sops/age/keys.txt";
          sops.secrets."git_token/public_repo" = { };
        };
      }
      {
        home.packages = with pkgs; [ qbittorrent lutris self.packages.x86_64-linux.neovim ];	
      }
    ];
  };

  flake.homeConfigurations.developer = withSystem "x86_64-linux" ({ pkgs, ... }:
    let
      args = import ./my-args.nix { inherit (pkgs) lib; } // {
        system = "x86_64-linux";
      }; 
    in
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          nixPkgsConfig
          self.homeModules.developer
          ./options
          ./desktop-environment/sway
          ./desktop-environment/waybar
          ./configurations
        ];
        extraSpecialArgs = args;
    });

  flake.nixosConfigurations.amd_b550i = withSystem "x86_64-linux" ({ pkgs, ... }: 
    let
      args = import ./my-args.nix { inherit (pkgs) lib; } // {
        system = "x86_64-linux";
      }; 
    in
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        nixPkgsConfig
        ({ modulesPath, ... }: {
          imports = [
            (modulesPath + "/installer/scan/not-detected.nix")
          ];
          system.stateVersion = "24.05";
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
        self.nixosModules.amd_b550i
        self.nixosModules.udisks2
        ./options
        ./sops.nix
        ./system
        ./desktop-environment
        ./configurations
        { _module.args = args; }
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = args;
          home-manager.users.developer = self.homeModules.developer;
        }
        {
          security.pam.services.swaylock = {
            text = ''
              auth include login
            '';
          };
          programs.dconf.enable = true;
        }
      ];
    });
  
  imports = [
    ./boot.nix
    ./graphics.nix
    ./fileSystems.nix
    ./audio.nix
    ./vpn.nix
  ];
}
