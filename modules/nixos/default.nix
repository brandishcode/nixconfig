top-level@{ withSystem, inputs , ... }:

{
  flake.nixosConfigurations.amd_b550i = withSystem "x86_64-linux" ({ pkgs, ... }: 
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
}
