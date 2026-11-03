{ ... }:

{
  flake.modules.nixvim.plugin-fugitive = {
    plugins.fugitive.enable = true;
    keymaps = [
      {
        action = "<cmd>G<cr>";
        key = "<leader>gs";
      }
    ];
  };
}
