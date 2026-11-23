{ self, inputs, ... }:

{
  perSystem = { pkgs, ... }: {
    packages.neovim =
      (inputs.nixvim.lib.evalNixvim {
        system = pkgs.system;
        modules = [
          # defaults
          self.modules.nixvim.base-config

          # plugins
          self.modules.nixvim.plugin-cmp
          self.modules.nixvim.plugin-fugitive
          self.modules.nixvim.plugin-undotree
          self.modules.nixvim.plugin-telescope
          self.modules.nixvim.plugin-lsp-ts_ls
        ];
      }).config.build.package;
  };

  flake.homeModules.neovim =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options = {
        programs.myneovim = lib.mkOption {
          default = {
            enable = true;
            package = self.packages.${pkgs.system}.neovim;

          };
          type = lib.types.attrs;
          description = ''
            Personal neovim package using nixvim
          '';
        };
      };
      config = {
        home.packages = lib.mkIf config.programs.myneovim.enable [ config.programs.myneovim.package ];
      };
    };

  imports = [
    ./plugins/cmp.nix
    ./plugins/fugitive.nix
    ./plugins/undotree.nix
    ./plugins/telescope.nix

    ./servers/ts_ls.nix

    ./baseConfig.nix
  ];

}
