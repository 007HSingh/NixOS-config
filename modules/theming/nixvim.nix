{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # ============================================
    # GLOBAL OPTIONS
    # ============================================
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      # Line Numbers
      number = true;
      relativenumber = true;

      # Indentation
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      autoindent = true;

      # Search
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;

      # UI & Behavior
      mouse = "a";
      clipboard = "unnamedplus";
      timeoutlen = 300;
      updatetime = 250;
      signcolumn = "yes";
      scrolloff = 8;
      sidescrolloff = 8;
      wrap = false;
      cursorline = true;
      termguicolors = true;
      splitright = true;
      splitbelow = true;
      showmode = false;

      # File Handling
      swapfile = false;
      backup = false;
      undofile = true;
      undodir = "${pkgs.stdenv.mkDerivation {
        name = "nvim-undo-dir";
        builder = pkgs.writeText "builder.sh" ''
          source $stdenv/setup
          mkdir -p $out
        '';
      }}";

      # Command Line
      cmdheight = 1;
      showcmd = true;
    };

    # ============================================
    # KEYMAPS
    # ============================================
    keymaps = [
      # Window Navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.silent = true;
      }

      # Window Resizing
      {
        mode = "n";
        key = "<C-Up>";
        action = ":resize +2<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = ":resize -2<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = ":vertical resize -2<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = ":vertical resize +2<CR>";
        options.silent = true;
      }

      # Buffer Navigation
      {
        mode = "n";
        key = "<S-l>";
        action = ":bnext<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<S-h>";
        action = ":bprevious<CR>";
        options.silent = true;
      }

      # Better Indenting
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.silent = true;
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.silent = true;
      }

      # Move Text Up and Down
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options.silent = true;
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options.silent = true;
      }

      # Keep Cursor Centered
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
        options.silent = true;
      }
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
        options.silent = true;
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
        options.silent = true;
      }

      # Clear Search Highlights
      {
        mode = "n";
        key = "<Esc>";
        action = ":noh<CR>";
        options.silent = true;
      }

      # Terminal Mode
      {
        mode = "t";
        key = "<C-h>";
        action = "<C-\\><C-n><C-w>h";
        options.silent = true;
      }
      {
        mode = "t";
        key = "<C-j>";
        action = "<C-\\><C-n><C-w>j";
        options.silent = true;
      }
      {
        mode = "t";
        key = "<C-k>";
        action = "<C-\\><C-n><C-w>k";
        options.silent = true;
      }
      {
        mode = "t";
        key = "<C-l>";
        action = "<C-\\><C-n><C-w>l";
        options.silent = true;
      }
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options.silent = true;
      }
    ];

    # ============================================
    # AUTOCOMMANDS
    # ============================================
    autoGroups = {
      highlight_yank = {
        clear = true;
      };
      resize_splits = {
        clear = true;
      };
      close_with_q = {
        clear = true;
      };
      disable_auto_comment = {
        clear = true;
      };
      checktime = {
        clear = true;
      };
      last_loc = {
        clear = true;
      };
    };

    autoCmd = [
      # Highlight on yank
      {
        event = "TextYankPost";
        group = "highlight_yank";
        callback = {
          __raw = ''
            function()
              vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
            end
          '';
        };
      }

      # Resize splits on window resize
      {
        event = "VimResized";
        group = "resize_splits";
        command = "tabdo wincmd =";
      }

      # Close certain filetypes with 'q'
      {
        event = "FileType";
        group = "close_with_q";
        pattern = [
          "help"
          "lspinfo"
          "man"
          "qf"
          "startuptime"
          "checkhealth"
          "fugitive"
        ];
        callback = {
          __raw = ''
            function(event)
              vim.bo[event.buf].buflisted = false
              vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
            end
          '';
        };
      }

      # Disable auto-commenting new lines
      {
        event = "BufEnter";
        group = "disable_auto_comment";
        callback = {
          __raw = ''
            function()
              vim.opt.formatoptions:remove({ "c", "r", "o" })
            end
          '';
        };
      }

      # Check if file changed outside of vim
      {
        event = [
          "FocusGained"
          "TermClose"
          "TermLeave"
        ];
        group = "checktime";
        command = "checktime";
      }

      # Restore cursor position
      {
        event = "BufReadPost";
        group = "last_loc";
        callback = {
          __raw = ''
            function()
              local mark = vim.api.nvim_buf_get_mark(0, '"')
              local lcount = vim.api.nvim_buf_line_count(0)
              if mark[1] > 0 and mark[1] <= lcount then
                pcall(vim.api.nvim_win_set_cursor, 0, mark)
              end
            end
          '';
        };
      }
    ];

    # ============================================
    # COLORSCHEME
    # ============================================
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = true;
        term_colors = true;
        integrations = {
          cmp = true;
          gitsigns = true;
          nvim_tree = true;
          treesitter = true;
          notify = true;
          mini = {
            enabled = true;
          };
          telescope = {
            enabled = true;
          };
          which_key = true;
          dap = {
            enabled = true;
            enable_ui = true;
          };
          neotest = true;
          indent_blankline = {
            enabled = true;
            colored_indent_levels = false;
          };
          native_lsp = {
            enabled = true;
            virtual_text = {
              errors = [ "italic" ];
              hints = [ "italic" ];
              warnings = [ "italic" ];
              information = [ "italic" ];
            };
            underlines = {
              errors = [ "underline" ];
              hints = [ "underline" ];
              warnings = [ "underline" ];
              information = [ "underline" ];
            };
          };
        };
      };
    };

    # ============================================
    # PLUGINS
    # ============================================

    # Telescope
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
      };
      settings = {
        defaults = {
          prompt_prefix = "🔍 ";
          selection_caret = "➤ ";
          sorting_strategy = "ascending";
          layout_config = {
            horizontal = {
              prompt_position = "top";
              preview_width = 0.55;
            };
            width = 0.87;
            height = 0.80;
          };
          mappings = {
            i = {
              "<C-u>" = false;
              "<C-d>" = false;
            };
          };
        };
        pickers = {
          find_files = {
            hidden = true;
          };
        };
      };
    };

    # Treesitter
    plugins.treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      nixvimInjections = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        python
        lua
        java
        nix
        c
        cpp
        markdown
        bash
        json
        yaml
        toml
        html
        css
        javascript
        typescript
        regex
        vim
        vimdoc
      ];
    };

    plugins.treesitter-context = {
      enable = true;
      settings = {
        enable = true;
        max_lines = 3;
        trim_scope = "outer";
      };
    };

    plugins.treesitter-textobjects = {
      enable = true;
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";
        };
      };
      move = {
        enable = true;
        setJumps = true;
        gotoNextStart = {
          "]f" = "@function.outer";
          "]c" = "@class.outer";
        };
        gotoPreviousStart = {
          "[f" = "@function.outer";
          "[c" = "@class.outer";
        };
      };
    };

    # LSP
    plugins.lsp = {
      enable = true;
      servers = {
        pyright = {
          enable = true;
          settings = {
            python.analysis = {
              typeCheckingMode = "basic";
              autoSearchPaths = true;
              useLibraryCodeForTypes = true;
            };
          };
        };
        jdtls.enable = true;
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              runtime.version = "LuaJIT";
              diagnostics.globals = [ "vim" ];
              workspace = {
                library = [ "\${3rd}/luv/library" ];
                checkThirdParty = false;
              };
              telemetry.enable = false;
              hint.enable = true;
            };
          };
        };
        nil_ls = {
          enable = true;
          settings = {
            nil.formatting.command = [ "nixfmt" ];
          };
        };
        clangd = {
          enable = true;
          cmd = [
            "clangd"
            "--background-index"
            "--clang-tidy"
            "--header-insertion=iwyu"
            "--completion-style=detailed"
            "--function-arg-placeholders"
          ];
        };
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
          settings = {
            cargo = {
              allFeatures = true;
              loadOutDirsFromCheck = true;
              runBuildScripts = true;
            };
            procMacro.enable = true;
            checkOnSave = true;
          };
        };
      };

      keymaps = {
        silent = true;
        lspBuf = {
          gD = "declaration";
          gd = "definition";
          K = "hover";
          gi = "implementation";
          "<C-k>" = "signature_help";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
          gr = "references";
        };
      };
    };

    plugins.fidget.enable = true;
    plugins.lsp-lines.enable = false;

    # Completion
    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif require('luasnip').expand_or_jumpable() then
                require('luasnip').expand_or_jump()
              else
                fallback()
              end
            end, { "i", "s" })
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif require('luasnip').jumpable(-1) then
                require('luasnip').jump(-1)
              else
                fallback()
              end
            end, { "i", "s" })
          '';
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          {
            name = "buffer";
            keyword_length = 3;
          }
        ];
        window = {
          completion = {
            border = "rounded";
          };
          documentation = {
            border = "rounded";
          };
        };
        formatting = {
          format = ''
            function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
              })[entry.source.name]
              return vim_item
            end
          '';
        };
      };
    };

    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-buffer.enable = true;
    plugins.cmp-path.enable = true;
    plugins.cmp_luasnip.enable = true;
    plugins.luasnip.enable = true;
    plugins.friendly-snippets.enable = true;

    # Formatting & Linting
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          python = [ "ruff_format" ];
          java = [ "google-java-format" ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          c = [ "clang_format" ];
          cpp = [ "clang_format" ];
          markdown = [ "prettier" ];
          json = [ "prettier" ];
          yaml = [ "prettier" ];
          rust = [ "rustfmt" ];
        };
        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
      };
    };

    plugins.lint = {
      enable = true;
      lintersByFt = {
        python = [
          "ruff"
          "mypy"
        ];
        java = [ "checkstyle" ];
        lua = [ "luacheck" ];
        rust = [ "clippy" ];
      };
      autoCmd = {
        event = [
          "BufWritePost"
          "BufReadPost"
          "InsertLeave"
        ];
        callback = {
          __raw = ''
            function()
              require('lint').try_lint()
            end
          '';
        };
      };
    };

    # DAP (Debugging)
    plugins.dap = {
      enable = true;
      extensions = {
        dap-ui = {
          enable = true;
          layouts = [
            {
              elements = [
                {
                  id = "scopes";
                  size = 0.25;
                }
                {
                  id = "breakpoints";
                  size = 0.25;
                }
                {
                  id = "stacks";
                  size = 0.25;
                }
                {
                  id = "watches";
                  size = 0.25;
                }
              ];
              size = 40;
              position = "left";
            }
            {
              elements = [
                {
                  id = "repl";
                  size = 0.5;
                }
                {
                  id = "console";
                  size = 0.5;
                }
              ];
              size = 10;
              position = "bottom";
            }
          ];
        };
        dap-virtual-text = {
          enable = true;
          virt_text_pos = "eol";
        };
        dap-python.enable = true;
      };

      signs = {
        dapBreakpoint = {
          text = "🔴";
          texthl = "";
        };
        dapBreakpointCondition = {
          text = "🟡";
          texthl = "";
        };
        dapBreakpointRejected = {
          text = "🚫";
          texthl = "";
        };
        dapStopped = {
          text = "➡️";
          texthl = "";
        };
      };
    };

    # Neotest
    plugins.neotest = {
      enable = true;
      adapters = {
        python = {
          enable = true;
          settings = {
            dap = {
              justMyCode = false;
            };
            args = [
              "--log-level"
              "DEBUG"
            ];
            runner = "pytest";
          };
        };
      };
      settings = {
        status = {
          virtual_text = true;
        };
        output = {
          open_on_run = true;
        };
      };
    };

    # UI Plugins
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          theme = "catppuccin";
          component_separators = {
            left = "";
            right = "";
          };
          section_separators = {
            left = "";
            right = "";
          };
          globalstatus = true;
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            "branch"
            "diff"
            "diagnostics"
          ];
          lualine_c = [
            {
              __unkeyed-1 = "filename";
              path = 1;
            }
          ];
          lualine_x = [
            "encoding"
            "fileformat"
            "filetype"
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };
    };

    plugins.bufferline = {
      enable = true;
      settings = {
        options = {
          diagnostics = "nvim_lsp";
          separator_style = "slant";
          offsets = [
            {
              filetype = "NvimTree";
              text = "File Explorer";
              highlight = "Directory";
              text_align = "left";
            }
          ];
        };
      };
    };

    plugins.alpha = {
      enable = true;
      layout = [
        {
          type = "padding";
          val = 2;
        }
        {
          type = "text";
          val = [
            "                                                     "
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
            "                                                    "
          ];
          opts = {
            position = "center";
            hl = "String";
          };
        }
        {
          type = "padding";
          val = 2;
        }
      ];
    };

    plugins.indent-blankline = {
      enable = true;
      settings = {
        indent = {
          char = "│";
        };
        scope = {
          enabled = true;
        };
      };
    };

    plugins.notify = {
      enable = true;
      backgroundColour = "#1e1e2e";
      fps = 60;
      render = "compact";
      stages = "fade_in_slide_out";
      timeout = 3000;
      topDown = false;
    };

    plugins.noice = {
      enable = true;
      lsp.override = {
        "vim.lsp.util.convert_input_to_markdown_lines" = true;
        "vim.lsp.util.stylize_markdown" = true;
        "cmp.entry.get_documentation" = true;
      };
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
        inc_rename = false;
        lsp_doc_border = true;
      };
    };

    plugins.dressing.enable = true;

    # File Explorer
    plugins.nvim-tree = {
      enable = true;
      sortBy = "case_sensitive";
      view.width = 30;
      renderer = {
        groupEmpty = true;
        icons.show.folderArrow = true;
      };
      filters.dotfiles = false;
      git = {
        enable = true;
        ignore = false;
      };
    };

    # Git Integration
    plugins.gitsigns = {
      enable = true;
      settings = {
        signs = {
          add.text = "│";
          change.text = "│";
          delete.text = "_";
          topdelete.text = "‾";
          changedelete.text = "~";
          untracked.text = "┆";
        };
      };
    };

    plugins.fugitive.enable = true;
    plugins.diffview.enable = true;
    plugins.lazygit.enable = true;

    # Terminal
    plugins.toggleterm = {
      enable = true;
      settings = {
        size = ''
          function(term)
            if term.direction == "horizontal" then
              return 15
            elseif term.direction == "vertical" then
              return vim.o.columns * 0.4
            end
          end
        '';
        open_mapping = "[[<c-\\>]]";
        hide_numbers = true;
        shade_terminals = true;
        shading_factor = 2;
        start_in_insert = true;
        insert_mappings = true;
        persist_size = true;
        direction = "horizontal";
        close_on_exit = true;
        shell = "vim.o.shell";
        float_opts = {
          border = "curved";
          winblend = 0;
        };
      };
    };

    # Editor Enhancements
    plugins.trouble.enable = true;
    plugins.comment.enable = true;
    plugins.nvim-autopairs = {
      enable = true;
      settings = {
        check_ts = true;
        ts_config = {
          lua = [ "string" ];
          javascript = [ "template_string" ];
          java = false;
        };
      };
    };
    plugins.nvim-surround.enable = true;
    plugins.flash.enable = true;
    plugins.zen-mode.enable = true;
    plugins.aerial.enable = true;
    plugins.persistence.enable = true;
    plugins.markdown-preview.enable = true;

    plugins.mini = {
      enable = true;
      modules = {
        ai = { };
        move = { };
      };
    };

    # Which-Key
    plugins.which-key = {
      enable = true;
      settings = {
        plugins = {
          marks = true;
          registers = true;
          spelling = {
            enabled = true;
            suggestions = 20;
          };
        };
        icons = {
          breadcrumb = "»";
          separator = "➜";
          group = "+";
        };
        win = {
          border = "rounded";
        };
      };
      registrations = {
        "<leader>f" = " Find";
        "<leader>g" = " Git";
        "<leader>h" = " Git Hunks";
        "<leader>l" = " LSP";
        "<leader>d" = " Debug";
        "<leader>T" = " Test";
        "<leader>c" = " Code";
        "<leader>b" = " Buffer";
        "<leader>x" = " Trouble";
        "<leader>t" = " Terminal";
        "<leader>s" = " Session";
        "<leader>m" = " Markdown";
      };
    };

    # Extra Lua Configuration
    extraConfigLua = ''
      -- Additional custom keymaps via which-key
      local wk = require("which-key")

      wk.add({
        -- Telescope
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
        
        -- File Explorer
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File Explorer" },
        { "<leader>o", "<cmd>NvimTreeFocus<cr>", desc = "Focus Explorer" },
        
        -- Misc
        { "<leader>w", "<cmd>w<CR>", desc = "Save" },
        { "<leader>q", "<cmd>q<CR>", desc = "Quit" },
        { "<leader>Q", "<cmd>qa!<CR>", desc = "Quit All" },
        { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
      })
    '';

    # Extra Packages
    extraPackages = with pkgs; [
      # Formatters
      ruff
      google-java-format
      stylua
      nixfmt-rfc-style
      nodePackages.prettier
      rustfmt

      # Linters
      checkstyle
      luajitPackages.luacheck
      clippy

      # Debuggers
      python3Packages.debugpy
      lldb

      # Tools
      ripgrep
      fd
      lazygit
      delta
    ];
  };
}
