top-level@{ withSystem, inputs , ... }:

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
      imports = [
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
	   home.packages = [ top-level.config.flake.packages.x86_64-linux.neovim ];	
	}
      ];
    };

    # flake.homeConfigurations.developer = withSystem "x86_64-linux" ({ pkgs, ... }:
    #   inputs.home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
    #     modules = [
    #       top-level.config.flake.homeModules.developer
    #       top-level.config.flake.homeModules.bash
    #       top-level.config.flake.homeModules.fcitx5
    #     ];
    #   });

  flake.nixosConfigurations.amd_b550i = withSystem "x86_64-linux" ({ pkgs, ... }: 
    let
      args = import ./my-args.nix { inherit (pkgs) lib; } // {
        system = "x86_64-linux";
      }; 
    in
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ({ ... }: {
          nixpkgs.overlays = [
            inputs.nur.overlays.default
          ];
          nixpkgs.config.allowUnfree = true;
          nixpkgs.config.problems.handlers = {
            "gtk+".broken = "warn"; # or "ignore"
          };
        })
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
          home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
          home-manager.users.developer = top-level.config.flake.homeModules.developer;
        }
      ];
    });
}
