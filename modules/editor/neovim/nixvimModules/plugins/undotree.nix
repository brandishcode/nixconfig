{ nixvimLib, ... }:

{
  plugins.undotree = {
    enable = true;
    settings = {
      UndoDir = nixvimLib.mkRaw "vim.fn.expand('~/.undodir')";
      SplitWidth = 50;
      SetFocusWhenToggle = true;
    };
  };
  
  opts = {
    undofile = true;
  };
}
