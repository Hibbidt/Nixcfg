{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.cli.nvf;
in {
  imports = [inputs.nvf.homeManagerModules.default];

  options.features.cli.nvf.enable = mkEnableOption "enable nvf";

  config = mkIf cfg.enable {
    #    home.packages = with pkgs; [];

    programs.nvf = {
      enableManpages = true;
      enable = true;

      settings = {
        vim = {
          extraPlugins = {
            dap-view = {
              package = pkgs.vimPlugins.nvim-dap-view;
              setup = "require('dap-view').setup {}";
            };
          };

          diagnostics = {
            enable = true;
            nvim-lint = {
              enable = true;
            };
            config = {
              virtual_lines = true;
            };
          };

          spellcheck = {
            enable = true;
            languages = [
              "en"
              "de"
            ];
            programmingWordlist.enable = true;
          };

          globals.mapleader = " ";

          # UndoTree Source path
          undoFile.path = "~/.vim/undodir/";

          options = {
            # Basic settings
            number = true; # Line numbers
            relativenumber = true; # Relative line numbers
            cursorline = true; # Highlight current line
            wrap = false; # Don't wrap lines
            scrolloff = 10; # Keep 10 lines above/below cursor
            sidescrolloff = 8; # Keep 8 columns left/right of cursor

            # Indentation
            tabstop = 2; # Tab width
            shiftwidth = 2; # Indent width
            softtabstop = 2; # Soft tab stop
            expandtab = true; # Use spaces instead of tabs
            smartindent = true; # Smart auto-indenting
            autoindent = true; # Copy indent from current line

            # Search settings
            ignorecase = true; # Case insensitive search
            smartcase = true; # Case sensitive if uppercase in search
            hlsearch = true; # Don't highlight search results
            incsearch = true; # Show matches as you type

            # Visual settings
            termguicolors = true; # Enable 24-bit colors
            signcolumn = "yes"; # Always show signcolumn also fixed weird jumping when editing on a new line
            showmatch = true; # Highlight matching brackets
            matchtime = 2; # How long to show matching bracket
            cmdheight = 1; # Command line height
            completeopt = "menuone,noselect,popup"; # Completion options
            wildmenu = true;
            wildmode = "longest:full,full";
            winborder = "double"; # Border Setting for completion
            showmode = false; # Don't show mode in command line
            pumheight = 10; # Popup menu height
            pumblend = 10; # Popup menu transparency
            winblend = 0; # Floating window transparency
            conceallevel = 0; # Don't hide markup
            concealcursor = ""; # Don't hide cursor line markup
            lazyredraw = true; # Don't redraw during macros
            synmaxcol = 300; # Syntax highlighting limit

            # File handling
            updatetime = 300; # Faster completion
            backup = false;
            writebackup = false;
            swapfile = false;
            undofile = true;
            timeoutlen = 500; # Key timeout duration
            ttimeoutlen = 0; # Key code timeout
            autoread = true; # Auto reload files changed outside vim
            autowrite = false; # Don't auto save

            # Behavior settings
            hidden = true; # Allow hidden buffers
            errorbells = false; # No error bells
            backspace = "indent,eol,start"; # Better backspace behavior
            autochdir = false; # Don't auto change directory
            selection = "exclusive"; # Selection behavior
            mouse = "a"; # Enable mouse support
            modifiable = true; # Allow buffer modifications
            encoding = "UTF-8"; # Set encoding

            # Split behavior
            splitbelow = true; # Horizontal splits go below
            splitright = true; # Vertical splits go right
          };

          keymaps = [
            # Keymaps/Remaps
            {
              mode = "n";
              key = "<Esc>";
              action = ":noh <CR>";
              desc = "Clear highlights";
            }
            # Dap-View
            {
              mode = "n";
              key = "<leader>du";
              action = "<cmd>DapViewToggle<cr>";
              desc = "Toggle Dap View";
            }
            # Quick file navigation
            {
              mode = "n";
              key = "<leader>cd";
              action = ":Ex<CR>";
              desc = "Open Netrw";
            }
            # # Undotreetoggle
            # {
            #   mode = "n";
            #   key = "<leader>t";
            #   action = ":m '<-2<CR>gv=gv";
            #   desc = "Toggle Undotree";
            # }
            # Misc
            {
              mode = "v";
              key = "K";
              action = ":m '<-2<CR>gv=gv";
              desc = "Moves marked block up";
            }
            {
              mode = "v";
              key = "J";
              action = ":m '>+1<CR>gv=gv";
              desc = "Moves marked block down";
            }
            {
              mode = "n";
              key = "J";
              action = "mzJ`z";
              desc = "Appends next line to current line while staying at the start of the line";
            }
            {
              mode = "n";
              key = "<C-d>";
              action = "<C-d>zz";
              desc = "Halfpage down";
            }
            {
              mode = "n";
              key = "<C-u>";
              action = "<C-u>zz";
              desc = "Halfpage up";
            }
            {
              mode = "n";
              key = "n";
              action = "nzzzv";
              desc = "Next searchterms stay in middle";
            }
            {
              mode = "n";
              key = "N";
              action = "Nzzzv";
              desc = "Previous searchterms stay in middle";
            }
            # Buffer navigation
            {
              mode = "n";
              key = "<leader>bn";
              action = ":bnext<CR>";
              desc = "Next buffer";
            }
            {
              mode = "n";
              key = "<leader>bp";
              action = ":bprev<CR>";
              desc = "Previous buffer";
            }
            {
              mode = "n";
              key = "<leader>bd";
              action = ":bd<CR>";
              desc = "Close buffer";
            }
            # Splitting & Resizing
            {
              mode = "n";
              key = "<leader>sv";
              action = ":vsplit<CR>";
              desc = "Split window vertically";
            }
            {
              mode = "n";
              key = "<leader>sh";
              action = ":split<CR>";
              desc = "Split window horizontally";
            }
            {
              mode = "n";
              key = "<C-UP>";
              action = ":resize +2<CR>";
              desc = "Increase Window height";
            }
            {
              mode = "n";
              key = "<C-Down>";
              action = ":resize -2<CR>";
              desc = "Decrease Window height";
            }
            {
              mode = "n";
              key = "<C-Left>";
              action = ":vertical resize +2<CR>";
              desc = "Increase Window width";
            }
            {
              mode = "n";
              key = "<C-Right>";
              action = ":vertical resize -2<CR>";
              desc = "Decrease Window width";
            }
            # Indent in visual mode
            {
              mode = "v";
              key = "<";
              action = "<gv";
              desc = "Indent left and reselect";
            }
            {
              mode = "v";
              key = ">";
              action = ">gv";
              desc = "Indent right and reselect";
            }
            # greatest remap ever
            {
              mode = "x";
              key = "<leader>p";
              action = "\"_dP";
              desc = "Overwrites selected without copying it";
            }
            {
              mode = [
                "n"
                "v"
              ];
              key = "<leader>z";
              action = "\"_d";
              desc = "Overwrites marked without copying it";
            }
            # next greatest remap ever : asbjornHaland
            {
              mode = [
                "n"
                "v"
                "x"
              ];
              key = "<leader>y";
              action = "\"+y";
              desc = "Copy to System clipboard";
            }
            {
              mode = "n";
              key = "<leader>Y";
              action = "\"+Y";
              desc = "Copy to Vim clipboard";
            }
            {
              mode = "n";
              key = "S";
              action = ":%s//g<Left><Left>";
              desc = "Replace";
            }
            {
              mode = [
                "n"
                "v"
              ];
              key = "<leader>ss";
              action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
              desc = "Replace string under Cursor";
            }
          ];

          autocmds = [
            # {
            #   event = [ "LspAttach" ];
            #   desc = "Lsp Menu Config";
            #   callback = lib.generators.mkLuaInline ''
            #     function()
            #         vim.highlight.on_yank()
            #     end
            #   '';
            # }
            {
              event = ["TextYankPost"];
              desc = "Highlight yanked text";
              callback = lib.generators.mkLuaInline ''
                function()
                    vim.highlight.on_yank()
                end
              '';
            }
            {
              event = ["BufReadPost"];
              desc = "Return to last edit position when opening files";
              callback = lib.generators.mkLuaInline ''
                function()
                  local mark = vim.api.nvim_buf_get_mark(0, '"')
                  local lcount = vim.api.nvim_buf_line_count(0)
                  if mark[1] > 0 and mark[1] <= lcount then
                    pcall(vim.api.nvim_win_set_cursor, 0, mark)
                  end
                end
              '';
            }
            {
              event = ["VimResized"];
              desc = "Auto-resize splits when window is resized";
              callback = lib.generators.mkLuaInline ''
                function()
                  vim.cmd("tabdo wincmd =")
                end
              '';
            }
            {
              event = ["BufWritePre"];
              desc = "Create directories when saving files";
              callback = lib.generators.mkLuaInline ''
                  function()
                  local dir = vim.fn.expand('<afile>:p:h')
                  if vim.fn.isdirectory(dir) == 0 then
                    vim.fn.mkdir(dir, 'p')
                  end
                end
              '';
            }
          ];

          telescope.enable = true;
          binds.whichKey.enable = true;
          autocomplete.blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
            setupOpts.keymap.preset = "default";
          };
          statusline.lualine.enable = true;
          utility.undotree.enable = true;

          debugger = {
            nvim-dap = {
              enable = true;
              #ui.enable = true;
            };
          };

          lsp = {
            enable = true;
          };

          languages = {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;
            enableDAP = true;

            lua = {
              enable = true;
            };
            nix = {
              enable = true;
              # lsp = { servers = [ "nixd" ]; };
            };
            clang = {
              enable = true;
            };
            csharp = {
              enable = true;
            };
            python = {
              enable = true;
            };
            typst = {
              enable = true;
              lsp = {
                servers = ["tinymist"];
              };
            };
          };
        };
      };
    };
  };
}
