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
        clean = "sudo nix-collect-garbage -d && sudo nix-store --optimise";
      };

    };

    neovim = {
      enable = true;
      defaultEditor = true;
      withPython3 = true;
      withNodeJs = true;
      vimAlias = true;
      viAlias = true;
    };
  };
}
