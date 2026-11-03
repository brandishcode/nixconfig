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

        ./modules/hosts/test
        ./modules/hosts/amd_b550i
        ./modules

        #  home-manager programs
        ./home-manager/programs/bash.nix
        ./home-manager/programs/fcitx5.nix
      ];
      systems = [ "x86_64-linux" "aarch64-darwin" ];
    };
}
