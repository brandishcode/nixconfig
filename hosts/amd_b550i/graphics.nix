{ ... }:

{
  flake.modules.nixos.graphics = { modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    hardware.enableRedistributableFirmware = true;
    hardware.cpu.amd.updateMicrocode = true;
  };
}
