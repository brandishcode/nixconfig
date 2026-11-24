{
  description = "brandishcode Own Nix config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/nur";
    sops-nix.url = "github:Mic92/sops-nix";
    nixvim.url = "github:nix-community/nixvim";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.flake-parts.flakeModules.modules
        inputs.home-manager.flakeModules.home-manager
        inputs.treefmt-nix.flakeModule
        inputs.git-hooks-nix.flakeModule

        # options
        ./options/theme.nix
        ./options/themes/tokyonight.nix

        # nixos configurations per host
        ./hosts/test
        ./hosts/B550I-AORUS-PRO-AX-rev-12

        # input managers
        ./inputManagers

        # packages
        ./packages
      ];
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      perSystem = { pkgs, config, ... }: {
        devShells.default =
          let
            # nixos rebuild scripts
            inherit (import ./scripts/nixos-rebuild-scripts.nix)
              nixosRebuildTest
              nixosRebuildSwitchProfile
              ;
          in
          pkgs.mkShell {
            buildInputs = [
              pkgs.sops
              (pkgs.callPackage nixosRebuildTest { })
              (pkgs.callPackage nixosRebuildSwitchProfile { })
            ];
            shellHook = ''
              ${config.pre-commit.shellHook}
            '';
          };
        treefmt = {
          programs.nixfmt.enable = true;
        };
        pre-commit.settings.hooks.nixfmt.enable = true;
      };
    };
}
