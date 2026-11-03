{  ... }:

{
  flake.modules.nixvim.plugin-undotree = { lib, ... }:
  let
    undodir = lib.nixvim.mkRaw "vim.fn.expand('~/.undodir')";
  in
  {
    plugins.undotree = {
      enable = true;
      settings = {
        UndoDir = undodir;
        SplitWidth = 50;
        SetFocusWhenToggle = true;
      };
    };
    
    opts = {
      inherit undodir;
      undofile = true;
    };
  
    keymaps = [
      {
        action = "<cmd>UndotreeToggle<cr>";
        key = "<leader>ut";
      }
    ];
  };
}

