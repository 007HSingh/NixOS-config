{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Version control
    gh

    # C tools
    gcc
    gnumake
    gdb

    # LSP
    nil

    # NodeJs
    nodejs_24

    # Rust tools
    rustc
    cargo
    rustup

    # Python
    python313
    python313Packages.pip
    python313Packages.pynvim

    # Java
    jdk21_headless
    jetbrains.idea-ultimate

    # Lua
    lua5_1
    lua51Packages.luarocks
    luajitPackages.luacheck
    stylua

    # Editor/IDE
    zed-editor-fhs
    antigravity-fhs
    android-studio
    android-studio-tools

    # Jupyter
    jupyter
  ];
}
