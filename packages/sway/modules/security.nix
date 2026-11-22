{ ... }:

{
  flake.nixosModules.swayNixos = { ... }: {
    security.polkit.enable = true;
  };
}
