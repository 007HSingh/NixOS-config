{
  pkgs,
  lib,
  ...
}:

{
  programs.nvf = {
    enable = true;
    settings.vim = {
      # Core Settings
      viAlias = true;
      vimAlias = true;

      # Vim Options
      options = {
        number = true;
        relativenumber = true;
        clipboard = "unnamedplus";
        mouse = "a";
        showmode = false;
        cmdheight = 1;
        updatetime = 300;
        signcolumn = "yes";
        timeoutlen = 500;
        ignorecase = true;
        smartcase = true;
        expandtab = true;
        shiftwidth = 2;
        tabstop = 2;
        smartindent = true;
        wrap = false;
        swapfile = false;
        backup = false;
        undofile = true;
        termguicolors = true;
        scrolloff = 8;
        sidescrolloff = 8;
        cursorline = true;
        splitbelow = true;
        splitright = true;
      };

      # Global Variables
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      # Dashboard
      dashboard.alpha.enable = true;

      # Theme
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      # Statusline
      statusline.lualine = {
        enable = true;
        theme = "catppuccin";
        globalStatus = true;
      };

      # Tabline
      tabline.nvimBufferline.enable = true;

      # Treesitter
      treesitter = {
        enable = true;
        fold = true;
        context.enable = true;
      };

      # Telescope
      telescope.enable = true;

      # Autocomplete
      autocomplete.nvim-cmp.enable = true;

      # Snippets
      snippets.luasnip.enable = true;

      # LSP
      lsp = {
        enable = true;
        formatOnSave = true;
        lspkind.enable = true;
        lightbulb.enable = true;
      };

      # DAP Debugger
      debugger.nvim-dap = {
        enable = true;
        ui.enable = true;
      };

      # Language Support
      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

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
        gitsigns.enable = true;
      };

      # File Tree
      filetree.neo-tree.enable = true;

      # Terminal
      terminal.toggleterm = {
        enable = true;
        direction = "horizontal";
        enable_winbar = false;
      };

      # Notifications
      notify.nvim-notify.enable = true;

      # Utility Plugins
      utility = {
        ccc.enable = true;
        preview.markdownPreview.enable = true;
        icon-picker.enable = true;
        surround.enable = true;
        diffview-nvim.enable = true;
        motion.leap.enable = true;
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

        noice.enable = true;

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

      # Notes
      notes.todo-comments.enable = true;

      # Projects
      projects.project-nvim.enable = true;

      # Custom Key Mappings
      keymaps = [
        # Window Navigation
        {
          mode = "n";
          key = "<C-h>";
          action = "<C-w>h";
          options.desc = "Navigate to left window";
        }
        {
          mode = "n";
          key = "<C-j>";
          action = "<C-w>j";
          options.desc = "Navigate to bottom window";
        }
        {
          mode = "n";
          key = "<C-k>";
          action = "<C-w>k";
          options.desc = "Navigate to top window";
        }
        {
          mode = "n";
          key = "<C-l>";
          action = "<C-w>l";
          options.desc = "Navigate to right window";
        }

        # Resize Windows
        {
          mode = "n";
          key = "<C-Up>";
          action = ":resize -2<CR>";
          options.desc = "Resize window up";
        }
        {
          mode = "n";
          key = "<C-Down>";
          action = ":resize +2<CR>";
          options.desc = "Resize window down";
        }
        {
          mode = "n";
          key = "<C-Left>";
          action = ":vertical resize -2<CR>";
          options.desc = "Resize window left";
        }
        {
          mode = "n";
          key = "<C-Right>";
          action = ":vertical resize +2<CR>";
          options.desc = "Resize window right";
        }

        # Quick Save/Quit
        {
          mode = "n";
          key = "<leader>w";
          action = ":w<CR>";
          options.desc = "Save file";
        }
        {
          mode = "n";
          key = "<leader>q";
          action = ":q<CR>";
          options.desc = "Quit";
        }

        # Clear Highlights
        {
          mode = "n";
          key = "<leader>nh";
          action = ":nohlsearch<CR>";
          options.desc = "Clear highlights";
        }

        # Better Indenting (Normal)
        {
          mode = "n";
          key = "<";
          action = "<<";
          options.desc = "Indent left";
        }
        {
          mode = "n";
          key = ">";
          action = ">>";
          options.desc = "Indent right";
        }

        # Better Indenting (Visual)
        {
          mode = "v";
          key = "<";
          action = "<gv";
          options.desc = "Indent left and reselect";
        }
        {
          mode = "v";
          key = ">";
          action = ">gv";
          options.desc = "Indent right and reselect";
        }

        # Move Text Up and Down (Visual)
        {
          mode = "v";
          key = "J";
          action = ":m '>+1<CR>gv=gv";
          options.desc = "Move text down";
        }
        {
          mode = "v";
          key = "K";
          action = ":m '<-2<CR>gv=gv";
          options.desc = "Move text up";
        }

        # File Explorer
        {
          mode = "n";
          key = "<leader>e";
          action = ":Neotree toggle<CR>";
          options.desc = "Toggle file explorer";
        }

        # Terminal
        {
          mode = "n";
          key = "<C-t>";
          action = ":ToggleTerm<CR>";
          options.desc = "Toggle terminal";
        }
      ];
    };
  };
}
