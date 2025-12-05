{ ... }:

{
  programs = {
    firefox.enable = true;
    git.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
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
        cd = "z"; # Uses zoxide
        update = "sudo nixos-rebuild switch --flake .#nixos";
        hm-update = "home-manager switch --flake .#harshs";
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
