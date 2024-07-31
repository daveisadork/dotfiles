---@type LazySpec[]
return {
  {
    "kkharji/sqlite.lua",
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>fm",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = function()
      return require "configs.conform"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      return require "configs.treesitter"
    end,
  },

  {
    "dariuscorvus/tree-sitter-language-injection.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "nvim-telescope/telescope-fzy-native.nvim",
        build = "cd deps/fzy-lua-native && make all",
        event = "BufRead",
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    opts = function()
      return require "configs.telescope"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("configs.lspconfig").defaults()
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "User FilePost",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "jay-babu/mason-null-ls.nvim",
        opts = function()
          return require "configs.none-ls"
        end,
      },
    },
    opts = function()
      local null_ls = require "null-ls"
      return {
        sources = {
          -- null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.hover.printenv,
          -- null_ls.builtins.formatting.xmlformat,
        },
      }
    end,
  },

  -- override plugin configs
  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.nvimtree",
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- "hrsh7th/cmp-nvim-lsp-signature-help",
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
        dependencies = {
          {
            "zbirenbaum/copilot.lua",
            opts = {
              suggestion = { enabled = false },
              panel = { enabled = false },
            },
          },
        },
      },
    },
    opts = function()
      return require "configs.nvim_cmp"
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.lsp_signature"
    end,
    -- config = function(_, opts)
    --   require("lsp_signature").setup(opts)
    -- end,
  },
  -- Install a plugin
  -- {
  --   "max397574/better-escape.nvim",
  --   event = "InsertEnter",
  --   config = function()
  --     require("better_escape").setup()
  --   end,
  -- },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {
      "Trouble",
      "TroubleClose",
      "TroubleRefresh",
      "TroubleToggle",
    },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
      {
        "gi",
        "<cmd>Trouble lsp_implementations<cr>",
        desc = "LSP Implementations",
      },
      {
        "gc",
        "<cmd>Trouble lsp_incoming_calls<cr>",
        desc = "LSP Implementations",
      },
      {
        "go",
        "<cmd>Trouble lsp_outgoing_calls<cr>",
        desc = "LSP Implementations",
      },
      {
        "gr",
        "<cmd>Trouble lsp_references<cr>",
        desc = "LSP References",
      },
      {
        "gd",
        "<cmd>Trouble lsp_definitions<cr>",
        desc = "LSP Definitions",
      },
      {
        "gt",
        "<cmd>Trouble lsp_type_definitions<cr>",
        desc = "LSP Type Definitions",
      },
    },
    opts = {
      mode = "document_diagnostics",
      auto_close = true,
      use_diagnostic_signs = false,
    }, -- for default options, refer to the configuration section for custom setup.
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "trouble")
      require("trouble").setup(opts)
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      {
        "kristijanhusak/vim-dadbod-completion",
        dependencies = {
          "hrsh7th/nvim-cmp",
        },
        ft = { "sql", "mysql", "plsql" },
        lazy = true,
        init = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "sql,mysql,plsql",
            callback = function()
              require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
            end,
          })
        end,
      },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_win_position = "right"
      vim.g.db_ui_winwidth = 60
      vim.g.db_ui_execute_on_save = 1
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    },
  },
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "luarocks.nvim",
    },
    keys = {
      {
        "<leader>rq",
        ":Rest run<CR>",
        mode = "",
        desc = "Run the request under the cursor",
      },
      {
        "<leader>rl",
        ":Rest log<CR>",
        mode = "",
        desc = "Request log",
      },
      {
        "<leader>rr",
        ":Rest last<CR>",
        mode = "",
        desc = "Rerun the last request",
      },
      {
        "<leader>rr",
        ":Rest last<CR>",
        mode = "",
        desc = "Rerun the last request",
      },
    },
    ft = { "http" },
    config = function()
      require("rest-nvim").setup {
        client = "curl",
        env_file = ".env",
        env_pattern = "\\.env$",
        env_edit_command = "tabedit",
        encode_url = true,
        skip_ssl_verification = false,
        custom_dynamic_variables = {},
        logs = {
          level = "info",
          save = true,
        },
        keybinds = {},
        result = {
          split = {
            horizontal = false,
            in_place = false,
            stay_in_current_window_after_split = true,
          },
          behavior = {
            decode_url = true,
            show_info = {
              url = true,
              headers = true,
              http_info = true,
              curl_command = true,
            },
            statistics = {
              enable = true,
              ---@see https://curl.se/libcurl/c/curl_easy_getinfo.html
              stats = {
                { "total_time", title = "Time taken:" },
                { "size_download_t", title = "Download size:" },
              },
            },
            formatters = {
              json = "jq",
              html = function(body)
                if vim.fn.executable "tidy" == 0 then
                  return body, { found = false, name = "tidy" }
                end
                local fmt_body = vim.fn
                  .system({
                    "tidy",
                    "-i",
                    "-q",
                    "--tidy-mark",
                    "no",
                    "--show-body-only",
                    "auto",
                    "--show-errors",
                    "0",
                    "--show-warnings",
                    "0",
                    "-",
                  }, body)
                  :gsub("\n$", "")

                return fmt_body, { found = true, name = "tidy" }
              end,
            },
          },
          keybinds = {
            buffer_local = true,
            prev = "H",
            next = "L",
          },
        },
        highlight = {
          enable = true,
          timeout = 750,
        },
      }
    end,
  },

  { "folke/lazydev.nvim", ft = "lua", opts = {
    library = {
      "lazy.nvim",
      "ui/nvchad_types",
    },
  } },

  {
    "vim-airline/vim-airline",
    enabled = false,
    init = function()
      vim.g.airline_powerline_fonts = 1
      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g["airline#extensions#tabline#tab_nr_type"] = 1
      vim.g["airline#extensions#tabline#buffer_nr_show"] = 1
      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g["airline#extensions#tmuxline#enabled"] = 1
      vim.g.airline_theme = "solarline"

      --vim.g.airline_left_sep = ""
      --vim.g.airline_left_alt_sep = ""
      --vim.g.airline_right_sep = ""
      --vim.g.airline_right_alt_sep = ""

      vim.g.airline_left_sep = ""
      vim.g.airline_left_alt_sep = ""
      vim.g.airline_right_sep = ""
      vim.g.airline_right_alt_sep = ""

      vim.g.airline_symbols = {
        crypt = "🔒",
        branch = "",
        readonly = "",
        linenr = "☰",
        maxlinenr = "",
        dirty = " ",
      }
    end,
  },

  {
    "vim-airline/vim-airline-themes",
    dependencies = {
      "vim-airline/vim-airline",
    },
  },

  {
    "edkolev/promptline.vim",
    cmd = {
      "PromplineSnapshot",
    },
    dependencies = {
      "vim-airline/vim-airline",
      "vim-airline/vim-airline-themes",
    },
    config = function()
      vim.cmd [[
        let g:promptline_preset = {
          \ 'a'    : [ promptline#slices#python_virtualenv() ],
          \ 'b'    : [ '$USER' ],
          \ 'c'    : [ '%~' ],
          \ 'x'    : [ promptline#slices#vcs_branch() ],
          \ 'y'    : [ promptline#slices#host({ 'only_if_ssh': 1  }) ],
          \ 'z'    : [],
          \ 'warn' : [ promptline#slices#last_exit_code() ],
          \ 'options': {
               \ 'left_sections' : [ 'y', 'b', 'a', 'x', 'c', 'z', 'warn' ],
               \ 'right_sections': []}}
      ]]
    end,
  },

  {
    "edkolev/tmuxline.vim",
    cmd = {
      "Tmuxline",
      "TmuxlineSimple",
      "TmuxlineSnapshot",
    },
    config = function()
      require "configs.tmuxline"
    end,
  },

  {
    "towolf/vim-helm",
    ft = { "yaml", "helm" },
  },

  {
    "ellisonleao/glow.nvim",
    ft = {
      "markdown",
    },
    cmd = {
      "Glow",
    },
    config = function()
      require("glow").setup()
    end,
  },

  {
    "isobit/vim-caddyfile",
    ft = { "caddyfile" },
  },

  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   opts = require "configs.blankline",
  -- },
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup {
  --       suggestion = {
  --         auto_trigger = true,
  --         keymap = {
  --           accept = "<C-e>",
  --         },
  --       },
  --     }
  --   end,
  -- },

  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python" },
  },

  {
    "tpope/vim-obsession",
  },
  {
    "aklt/plantuml-syntax",
    lazy = false,
  },
  {
    "scrooloose/vim-slumlord",
    ft = "plantuml",
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    opts = {
      lightbulb = {
        enabled = false,
        sign = false,
        virtual_text = false,
        enable_in_insert = false,
      },
      diagnostic = {
        only_current = true,
      },
      beacon = {
        enable = false,
      },
      code_action = {
        extend_gitsigns = false,
        keys = {
          quit = "<esc>",
          exec = "<CR>",
        },
      },
      ui = {
        title = true,
        border = "rounded",
        devicon = true,
        collapse = "",
        expand = "",
        code_action = " 󰛩",
        lines = { "╰", "├", "│", "─", "╭" },
      },
    },
    config = function(_, opts)
      -- dofile(vim.g.base46_cache .. "lspsaga")
      require("lspsaga").setup(opts)
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
    keys = {
      {
        "<C-j>",
        ":Lspsaga diagnostic_jump_next<CR>",
        mode = "",
        desc = "Diagnostic jump next",
      },
      {
        "<C-k>",
        ":Lspsaga diagnostic_jump_prev<CR>",
        mode = "",
        desc = "Diagnostic jump prev",
      },
      {
        "K",
        ":Lspsaga hover_doc<CR>",
        mode = "",
        desc = "LSP Hover",
      },
      {
        "<leader>ci",
        ":Lspsaga incoming_calls<CR>",
        mode = "",
        desc = "Incoming calls",
      },
      {
        "<leader>ca",
        ":Lspsaga code_action<CR>",
        mode = "",
        desc = "Code actions",
      },
    },
  },
  {
    "romgrk/barbar.nvim",
    enabled = false,
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
      icons = {
        preset = "slanted",
        separator = { left = "", right = "" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return require "configs.bufferline"
    end,
  },
}
