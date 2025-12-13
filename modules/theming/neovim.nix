{
  pkgs,
  lib,
  ...
}:

{
  vim = {
    # Core Settings
    viAlias = true;
    vimAlias = true;
    debugMode = {
      enable = false;
      level = 16;
      logFile = "/tmp/nvim.log";
    };

    # Spellcheck
    spellcheck = {
      enable = true;
      languages = ["en"];
    };

    # Line Numbers & Visual Enhancements
    lineNumberMode = "relNumber";
    useSystemClipboard = true;
    preventJunkFiles = true;
    cmdHeight = 1;
    updateTime = 300;
    showSignColumn = true;
    bell = "none";
    mapTimeout = 500;

    # Search Settings
    searchCase = "smart";

    # Undo & Backup
    undoFile = {
      enable = true;
    };

    # Mouse Support
    mouse = {
      enable = true;
      support = "a";
    };

    # Dashboard
    dashboard.alpha = {
      enable = true;
    };

    # Theme
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = false;
    };

    # Statusline
    statusline.lualine = {
      enable = true;
      theme = "catppuccin";
      icons.enable = true;
      globalStatus = true;
      refresh = {
        statusline = 100;
        tabline = 100;
        winbar = 100;
      };
    };

    # Tabline
    tabline.nvimBufferline = {
      enable = true;
      mappings = {
        closeCurrent = "<leader>bc";
        cycleNext = "<TAB>";
        cyclePrevious = "<S-TAB>";
        pick = "<leader>bp";
        sortByExtension = "<leader>bse";
        sortByDirectory = "<leader>bsd";
        moveNext = "<leader>bmn";
        movePrevious = "<leader>bmp";
      };
    };

    # Treesitter - Enhanced Syntax Highlighting
    treesitter = {
      enable = true;
      fold = true;
      context.enable = true;
      highlight.enable = true;
      indent.enable = true;
      autotagHtml = true;
    };

    # Telescope - Fuzzy Finder
    telescope = {
      enable = true;
      mappings = {
        findFiles = "<leader>ff";
        liveGrep = "<leader>fg";
        buffers = "<leader>fb";
        helpTags = "<leader>fh";
        open = "<leader>ft";
        gitCommits = "<leader>gc";
        gitBufferCommits = "<leader>gbc";
        gitBranches = "<leader>gb";
        gitStatus = "<leader>gs";
        gitStash = "<leader>gx";
      };
    };

    # Autocomplete
    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        complete = "<C-Space>";
        confirm = "<CR>";
        next = "<Tab>";
        previous = "<S-Tab>";
        close = "<C-e>";
        scrollDocsUp = "<C-u>";
        scrollDocsDown = "<C-d>";
      };
      sources = {
        nvim-cmp = true;
        buffer = true;
        path = true;
        nvim_lsp = true;
        luasnip = true;
      };
    };

    # Snippets
    snippets.luasnip = {
      enable = true;
    };

    # LSP Configuration
    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = true;
      lightbulb.enable = true;
      lsplines.enable = true;
      nvimCodeActionMenu.enable = true;

      mappings = {
        goToDeclaration = "gD";
        goToDefinition = "gd";
        goToType = "gt";
        listImplementations = "gi";
        listReferences = "gr";
        nextDiagnostic = "]d";
        previousDiagnostic = "[d";
        openDiagnosticFloat = "<leader>e";
        documentHighlight = "<leader>h";
        listDocumentSymbols = "<leader>ds";
        addWorkspaceFolder = "<leader>wa";
        removeWorkspaceFolder = "<leader>wr";
        listWorkspaceFolders = "<leader>wl";
        listWorkspaceSymbols = "<leader>ws";
        hover = "K";
        signatureHelp = "<C-k>";
        renameSymbol = "<leader>rn";
        codeAction = "<leader>ca";
        format = "<leader>f";
      };
    };

    # Debugger (DAP)
    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;
      mappings = {
        continue = "<leader>dc";
        restart = "<leader>dr";
        terminate = "<leader>dq";
        runLast = "<leader>d.";
        toggleRepl = "<leader>dR";
        hover = "<leader>dh";
        toggleBreakpoint = "<leader>db";
        runToCursor = "<leader>dgc";
        stepInto = "<leader>di";
        stepOut = "<leader>do";
        stepOver = "<leader>dO";
        stepBack = "<leader>dB";
        goUp = "<leader>du";
        goDown = "<leader>dd";
      };
    };

    # Language Support
    languages = {
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      # System Languages
      nix = {
        enable = true;
        format.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      lua = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      bash = {
        enable = true;
        lsp.enable = true;
        format.enable = true;
        treesitter.enable = true;
      };

      # Systems Programming
      clang = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
        dap.enable = true;
      };

      rust = {
        enable = true;
        lsp.enable = true;
        format.enable = true;
        treesitter.enable = true;
        dap.enable = true;
      };

      # Application Development
      java = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      python = {
        enable = true;
        lsp.enable = true;
        format.enable = true;
        treesitter.enable = true;
        dap.enable = true;
      };

      go = {
        enable = true;
        lsp.enable = true;
        format.enable = true;
        treesitter.enable = true;
        dap.enable = true;
      };

      # Web Development
      ts = {
        enable = true;
        lsp.enable = true;
        format.enable = true;
        treesitter.enable = true;
      };

      html = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      css = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      tailwind = {
        enable = true;
        lsp.enable = true;
      };

      # Data & Config
      sql = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      markdown = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
    };

    # Git Integration
    git = {
      enable = true;
      gitsigns = {
        enable = true;
        mappings = {
          nextHunk = "]c";
          previousHunk = "[c";
          stageHunk = "<leader>hs";
          resetHunk = "<leader>hr";
          undoStageHunk = "<leader>hu";
          stageBuffer = "<leader>hS";
          resetBuffer = "<leader>hR";
          previewHunk = "<leader>hp";
          blameLine = "<leader>hb";
          diffThis = "<leader>hd";
          diffProject = "<leader>hD";
          toggleBlame = "<leader>tb";
          toggleDeleted = "<leader>td";
        };
      };
    };

    # File Tree
    filetree.neo-tree = {
      enable = true;
      mappings = {
        toggle = "<leader>e";
        focus = "<leader>o";
        findFile = "<leader>n";
        refresh = "<leader>r";
      };
    };

    # Terminal
    terminal.toggleterm = {
      enable = true;
      mappings = {
        open = "<C-t>";
      };
      direction = "horizontal";
      enable_winbar = false;
    };

    # Notifications
    notify.nvim-notify = {
      enable = true;
      background_colour = "#000000";
      timeout = 3000;
    };

    # Utility Plugins
    utility = {
      # Session Management
      vim-wakatime.enable = false;

      # Color Highlighter
      ccc.enable = true;

      # Image Viewing
      image-nvim.enable = false;

      # Markdown Preview
      preview.markdownPreview.enable = true;

      # Icons
      icon-picker.enable = true;

      # Surround
      surround.enable = true;

      # Diffview
      diffview-nvim.enable = true;

      # Motion
      leap.enable = true;

      # Comments
      comment.comment-nvim = {
        enable = true;
        mappings = {
          toggleCurrentLine = "gcc";
          toggleCurrentBlock = "gbc";
          toggleOpLeaderLine = "gc";
          toggleOpLeaderBlock = "gb";
          toggleSelectedLine = "gc";
          toggleSelectedBlock = "gb";
        };
      };
    };

    # UI Enhancements
    ui = {
      borders.enable = true;
      colorizer.enable = true;

      illuminate.enable = true;

      breadcrumbs = {
        enable = true;
        navbuddy.enable = true;
      };

      noice = {
        enable = true;
      };

      smartcolumn = {
        enable = true;
        columnAt.languages = {
          nix = 100;
          rust = 100;
          python = 88;
          java = 120;
        };
      };
    };

    # Autopairs
    autopairs.nvim-autopairs.enable = true;

    # Notes (optional)
    notes = {
      obsidian.enable = false;
      orgmode.enable = false;
      mind-nvim.enable = false;
      todo-comments.enable = true;
    };

    # Projects
    projects.project-nvim = {
      enable = true;
      manualMode = false;
    };

    # Presence (Discord - optional)
    presence.neocord = {
      enable = false;
    };

    # Custom Key Mappings
    maps = {
      normal = {
        # Better window navigation
        "<C-h>" = {
          action = "<C-w>h";
          desc = "Navigate to left window";
        };
        "<C-j>" = {
          action = "<C-w>j";
          desc = "Navigate to bottom window";
        };
        "<C-k>" = {
          action = "<C-w>k";
          desc = "Navigate to top window";
        };
        "<C-l>" = {
          action = "<C-w>l";
          desc = "Navigate to right window";
        };

        # Resize windows
        "<C-Up>" = {
          action = ":resize -2<CR>";
          desc = "Resize window up";
        };
        "<C-Down>" = {
          action = ":resize +2<CR>";
          desc = "Resize window down";
        };
        "<C-Left>" = {
          action = ":vertical resize -2<CR>";
          desc = "Resize window left";
        };
        "<C-Right>" = {
          action = ":vertical resize +2<CR>";
          desc = "Resize window right";
        };

        # Quick save
        "<leader>w" = {
          action = ":w<CR>";
          desc = "Save file";
        };

        # Quick quit
        "<leader>q" = {
          action = ":q<CR>";
          desc = "Quit";
        };

        # Clear highlights
        "<leader>h" = {
          action = ":nohlsearch<CR>";
          desc = "Clear highlights";
        };

        # Better indenting
        "<" = {
          action = "<<";
          desc = "Indent left";
        };
        ">" = {
          action = ">>";
          desc = "Indent right";
        };
      };

      visual = {
        # Better indenting
        "<" = {
          action = "<gv";
          desc = "Indent left and reselect";
        };
        ">" = {
          action = ">gv";
          desc = "Indent right and reselect";
        };

        # Move text up and down
        "J" = {
          action = ":m '>+1<CR>gv=gv";
          desc = "Move text down";
        };
        "K" = {
          action = ":m '<-2<CR>gv=gv";
          desc = "Move text up";
        };
      };
    };

    # Leader Key
    globals.mapleader = " ";
    globals.maplocalleader = " ";
  };
}
