# Bootloader
{
  boot = {
    kernelParams = [
      "quiet"
      "loglevel=3"
      "rd.systemd.show_status=0"
      "udev.log_level=3"
    ];
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };
  };
}
