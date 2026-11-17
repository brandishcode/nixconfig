{ self, inputs, ... }:

{
  perSystem = { system, ... }: {
    packages.neovim =
      (inputs.nixvim.lib.evalNixvim {
        inherit system;

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

  imports = [
    ./plugins/cmp.nix
    ./plugins/fugitive.nix
    ./plugins/undotree.nix
    ./plugins/telescope.nix

    ./servers/ts_ls.nix

    ./baseConfig.nix
  ];

}
