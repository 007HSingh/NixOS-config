{ pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
  };

  # Optional: Enable Plasma as fallback desktop
  # services.desktopManager.plasma6.enable = true;

  # Catppuccin theme
  catppuccin = {
    enable = true;
    cache.enable = true;
    grub.enable = true;
    grub.flavor = "mocha";
  };
}
