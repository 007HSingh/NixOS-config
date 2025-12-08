{
  pkgs,
  ...
}:

{
  programs.niri.enable = true;

  environment.systemPackges = with pkgs; [
    niri
    xwayland-satellite
  ];
}
