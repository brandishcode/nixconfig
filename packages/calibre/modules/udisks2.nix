{ ... }:

{
  flake.nixosModules.calibre = { ... }: {
    services.udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
}
