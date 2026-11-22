{ ... }:

{
  flake.nixosModules.amd_b550i = { ... }: {
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/mainboot";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-label/home";
      fsType = "ext4";
    };

    fileSystems."/development" = {
      device = "/dev/disk/by-label/development";
      fsType = "ext4";
    };

    fileSystems."/documents" = {
      device = "/dev/disk/by-label/documents";
      fsType = "ext4";
    };
  };
}
