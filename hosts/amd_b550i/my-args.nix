{ lib }:

let
  myLib = import ./type-checker.nix { inherit lib; };
  myTypes = import ./types.nix { inherit myLib lib; };
in
{
  inherit myLib myTypes;
}
