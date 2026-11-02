{ nixvimLib, ... }:

let
  undodir = nixvimLib.mkRaw "vim.fn.expand('~/.undodir')";
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
}
