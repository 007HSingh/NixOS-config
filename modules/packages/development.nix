{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Version control
    gh

    # Build tools
    gdb

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

    # Jupyter
    jupyter
  ];
}
