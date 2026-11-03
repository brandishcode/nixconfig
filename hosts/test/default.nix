top-level@{ withSystem, inputs , ... }:

{
  flake.nixosConfigurations.test = withSystem "x86_64-linux" ({ pkgs, ... }: 
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
        ./virtualization-test.nix
        inputs.home-manager.nixosModules.home-manager
        {
          virtualisation.vmVariant = {
            home-manager.useUserPackages = true;
            home-manager.users.test = top-level.config.flake.homeModules.test;
          };
        }
      ];
    });

  flake.homeModules.test = { pkgs, ... }: {
    home.homeDirectory = "/home/test";
      home.username = "test";
      home.stateVersion = "26.11";
      programs.git.enable = true;
    };
    flake.homeConfigurations.test = withSystem "x86_64-linux" ({ pkgs, ... }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          top-level.config.flake.homeModules.test
        ];
      });
}
