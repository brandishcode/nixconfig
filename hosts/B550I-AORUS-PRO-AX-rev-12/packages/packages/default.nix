{ pkgs, ... }:

{
  home.packages = [
    pkgs.protonmail-desktop
  ]
  ++ (with pkgs; [ npins ]);
}
