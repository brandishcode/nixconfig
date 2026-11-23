{ ... }:

{
  flake.nixosModules.B550I-AORUS-PRO-AX-rev-12 = { modulesPath, ... }: {
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
