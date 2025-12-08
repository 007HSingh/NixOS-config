{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withPython3 = true;
    withNodeJs = true;
    withRuby = false;

    # ALL your plugins declared here
    plugins = with pkgs.vimPlugins; [
      # ============================================
      # CORE DEPENDENCIES
      # ============================================
      plenary-nvim
      nvim-web-devicons
      nui-nvim

      # ============================================
      # FUZZY FINDER
      # ============================================
      telescope-nvim
      telescope-fzf-native-nvim

      # ============================================
      # TREESITTER (with parsers)
      # ============================================
      (nvim-treesitter.withPlugins (p: [
        p.python
        p.lua
        p.java
        p.nix
        p.c
        p.cpp
        p.markdown
        p.bash
        p.json
        p.yaml
        p.toml
        p.html
        p.css
        p.javascript
        p.typescript
        p.regex
        p.vim
        p.vimdoc
      ]))
      nvim-treesitter-context
      nvim-treesitter-textobjects

      # ============================================
      # LSP
      # ============================================
      nvim-lspconfig
      lazydev-nvim
      fidget-nvim

      # ============================================
      # COMPLETION
      # ============================================
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      friendly-snippets

      # ============================================
      # FORMATTING & LINTING
      # ============================================
      conform-nvim
      nvim-lint

      # ============================================
      # DEBUGGING (DAP)
      # ============================================
      nvim-dap
      nvim-dap-ui
      nvim-nio
      nvim-dap-virtual-text
      nvim-dap-python

      # ============================================
      # TESTING
      # ============================================
      neotest
      neotest-python
      neotest-plenary

      # ============================================
      # UI & THEME
      # ============================================
      catppuccin-nvim
      lualine-nvim
      bufferline-nvim
      alpha-nvim
      indent-blankline-nvim
      dressing-nvim
      nvim-notify
      noice-nvim

      # ============================================
      # FILE EXPLORER
      # ============================================
      nvim-tree-lua

      # ============================================
      # GIT
      # ============================================
      gitsigns-nvim
      vim-fugitive
      diffview-nvim
      lazygit-nvim

      # ============================================
      # TERMINAL
      # ============================================
      toggleterm-nvim

      # ============================================
      # NAVIGATION & EDITING
      # ============================================
      flash-nvim
      nvim-surround
      comment-nvim
      nvim-autopairs
      mini-nvim

      # ============================================
      # UTILITIES
      # ============================================
      which-key-nvim
      trouble-nvim
      aerial-nvim
      persistence-nvim
      zen-mode-nvim
      markdown-preview-nvim
    ];

    # ALL your external tools here
    extraPackages = with pkgs; [
      # ===== LSP SERVERS =====
      pyright
      jdt-language-server
      lua-language-server
      nil # Nix LSP
      clang-tools
      rust-analyzer

      # ===== FORMATTERS =====
      ruff
      google-java-format
      stylua
      nixfmt-rfc-style
      nodePackages.prettier
      rustfmt

      # ===== LINTERS =====
      checkstyle
      luajitPackages.luacheck
      clippy

      # ===== DEBUGGERS =====
      python3Packages.debugpy
      lldb
      vscode-extensions.vadimcn.vscode-lldb

      # ===== TREESITTER =====
      tree-sitter

      # ===== TELESCOPE DEPENDENCIES =====
      ripgrep
      fd

      # ===== GIT =====
      lazygit
      delta
    ];

    extraLuaConfig = ''
      -- Load your modular config
      require("config.options")
      require("config.keymaps")
      require("config.autocmds")

      -- Load plugin configurations
      require("plugins.telescope")
      require("plugins.treesitter")
      require("plugins.lsp")
      require("plugins.cmp")
      require("plugins.dap")
      require("plugins.neotest")
      require("plugins.ui")
      require("plugins.git")
      require("plugins.editor")
    '';
  };
}
