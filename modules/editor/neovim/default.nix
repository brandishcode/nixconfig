{ ... }:

{
  imports = [ ./nixvimLib.nix ];
  perSystem = { system, nixvimLib, ... }:
    let
    configuration = nixvimLib.evalNixvim {
      inherit system; 
      modules = [
        # defaults
        ./nixvimModules/baseConfig.nix 
        ./nixvimModules/keyMappings
        ./nixvimModules/plugins

        # key mappings
        ./nixvimModules/keyMappings/cmp.nix

        # plugins
        ./nixvimModules/plugins/cmp.nix
      ];
    }; 
  in
  {
    packages.neovim = configuration.config.build.package;
  };
}
