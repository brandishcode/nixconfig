{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "gtk";
    style.package = pkgs.tokyonight-gtk-theme;
  };
}
