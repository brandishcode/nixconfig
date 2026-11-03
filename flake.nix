{
  description = "brandishcode Own Nix config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/nur";
    sops-nix.url = "github:Mic92/sops-nix";
    nixvim.url = "github:nix-community/nixvim";

  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.home-manager.flakeModules.home-manager

        # nixos configurations per host
        ./hosts/test
        ./hosts/amd_b550i

        # home-manager programs
        ./home-manager/programs/bash.nix
        ./home-manager/programs/fcitx5.nix

        # packages
        ./packages
      ];
      systems = [ "x86_64-linux" "aarch64-darwin" ];
    };
}
