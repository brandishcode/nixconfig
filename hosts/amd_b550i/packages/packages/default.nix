inputs@{ pkgs, ... }:

let
  calibre = import ./calibre inputs;
in
{
  home.packages = [
    calibre
    pkgs.protonmail-desktop
  ]
  ++ (with pkgs; [ npins ]);
}
