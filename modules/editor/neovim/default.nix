{ ... }:

{
  imports = [ ./nixvimLib.nix ];
  perSystem = { system, nixvimLib, ... }:
    let
    configuration = nixvimLib.evalNixvim {
      inherit system; 
      modules = [
        ./nixvimModules/baseConfig.nix 
        ./nixvimModules/keyMappings
        ./nixvimModules/plugins
      ];
    }; 
  in
  {
    packages.neovim = configuration.config.build.package;
  };
}
