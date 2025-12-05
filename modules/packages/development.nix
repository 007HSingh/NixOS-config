{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Version control
    gh

    # Build tools
    gcc15
    gnumake
    gdb
    clang-tools

    # Node.js
    nodejs_24
    nodePackages.prettier

    # Python
    pyright
    black
    isort
    mypy
    (python313.withPackages (
      ps: with ps; [
        flake8
        pytest_7
        debugpy
        pip
        pynvim
        uv
      ]
    ))

    # Java
    jdt-language-server
    jdk21_headless
    google-java-format
    checkstyle
    jetbrains.idea-ultimate

    # Lua
    lua-language-server
    lua5_1
    lua51Packages.luarocks
    luajitPackages.luacheck
    stylua

    # Nix
    nil
    nixfmt-rfc-style

    # Editor/IDE
    tree-sitter
    vscode-fhs

    # Jupyter
    jupyter
  ];
}
