toplevel@{ inputs, ... }:

{
    flake.homeModules.test = { pkgs, ... }: {
      home.stateVersion = "26.11";
      programs.git.enable = true;
    };
    flake.homeConfigurations.root = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
      modules = [
        toplevel.config.flake.homeModules.developer
      ];
    };
}
