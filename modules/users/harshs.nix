{ pkgs, ... }:

{
  users.users.harshs = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Harsh Singh";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
}
