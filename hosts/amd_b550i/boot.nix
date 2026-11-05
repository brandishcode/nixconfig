{ ... }:

{
  flake.nixosModules.amd_b550i = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.extraEntries = {
      "arch.conf" = ''
        title   Arch Linux
        linux   /vmlinuz-linux
        initrd  /initramfs-linux.img
        options root=UUID=954bde48-30b6-417d-b04c-c1debaa2eafe rw
      '';
      "arch-fallback.conf" = ''
        title   Arch Linux (fallback initframs)
        linux   /vmlinuz-linux
        initrd  /initramfs-linux-fallback.img
        options root=UUID=954bde48-30b6-417d-b04c-c1debaa2eafe rw
      '';
    };
    boot.loader.efi.canTouchEfiVariables = true;
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.extraModulePackages = [ ];
    boot.kernelModules = [ "kvm-amd" ];
  };
}
