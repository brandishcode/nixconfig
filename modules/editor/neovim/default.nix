{ ... }:

{
  imports = [ ./nixvimLib.nix ];
  perSystem = { system, nixvimLib, ... }:
    let
    configuration = nixvimLib.evalNixvim {
      inherit system; 
      extraSpecialArgs = {
        nixvimLib = nixvimLib.nixvim;
      };
      modules = [
        # defaults
        ./nixvimModules/baseConfig.nix 
        ./nixvimModules/keyMappings
        ./nixvimModules/plugins

        # key mappings
        ./nixvimModules/keyMappings/cmp.nix
        ./nixvimModules/keyMappings/fugitive.nix
        ./nixvimModules/keyMappings/undotree.nix

        # plugins
        ./nixvimModules/plugins/cmp.nix
        ./nixvimModules/plugins/fugitive.nix
        ./nixvimModules/plugins/undotree.nix
      ];
    }; 
  in
  {
    packages.neovim = configuration.config.build.package;
  };
}
