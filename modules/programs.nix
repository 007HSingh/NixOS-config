{ ... }:

{
  programs = {
    firefox.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions = {
        enable = true;
        async = true;
      };
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "docker"
          "kubectl"
          "colored-man-pages"
        ];
      };

      shellAliases = {
        ls = "eza --icons";
        ll = "eza -la --icons";
        cat = "bat";
        update = "sudo nixos-rebuild switch --flake .#nixos";
        hm-update = "home-manager switch --flake .#harshs";
        generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
        clean = "sudo nix-collect-garbage -d";
        diff-system = "nvd diff /nix/var/nix/profiles/system-*-link | tail -n 2 | head -n 1 /nix/var/nix/profiles/system-*-link | tail -n 1";
      };

    };
  };
}
