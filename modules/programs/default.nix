{ ... }:

{
  programs = {
    firefox.enable = true;
    git.enable = true;
    zsh.enable = true;

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
