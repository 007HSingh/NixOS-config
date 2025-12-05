{ pkgs, ... }:

{
  networking = {
    hostName = "nixos";

    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };

    # Firewall configuration
    firewall = {
      enable = true;
      #   allowedTCPPorts = [ ];
      #   allowedUDPPorts = [ ];
    };
  };
}
