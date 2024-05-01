local null_ls = require "null-ls"
local mason_null_ls = require "mason-null-ls"

local h = require "null-ls.helpers"
local u = require "null-ls.utils"
local methods = require "null-ls.methods"

local FORMATTING = methods.internal.FORMATTING

mason_null_ls.setup {
  ensure_installed = {
    -- -- misc
    -- "impl",
    --
    -- -- go
    -- "gofumpt",
    -- "goimports",
    -- "gomodifytags",
    -- "golangci_lint",
    --
    -- -- javascript
    -- "prettierd",
    --
    -- -- python
    -- -- "black",
    -- -- "usort",
    --
    -- -- lua
    -- "stylua",
    --
    -- -- sql
    --"sql_formatter",
  },
  automatic_installation = false,
  handlers = {
    darker = function()
      -- custom logic
      null_ls.register {
        name = "darker",
        meta = {
          url = "https://github.com/psf/black",
          description = "The uncompromising Python code formatter",
        },
        method = { FORMATTING },
        filetypes = { "python" },
        generator = h.formatter_factory {
          command = "darker",
          args = {
            "--stdin-filename",
            "$FILENAME",
            "--flynt",
            "--quiet",
            "--stdout",
          },
          to_stdin = true,
        },
      }
    end,
    goimports = function(source, types)
      -- custom logic
      vim.tbl_map(function(type)
        null_ls.register(null_ls.builtins[type][source].with {
          filetypes = { "go" },
          generator_opts = {
            command = "goimports",
            args = { "-srcdir", "$DIRNAME", "-local", "gitlab.sezzle.com" },
            to_stdin = true,
            prepend_extra_args = true,
          },
        })
      end, types)
    end,
    -- isort = function(source, types)
    --   -- custom logic
    --   vim.tbl_map(function(type)
    --     null_ls.register(null_ls.builtins[type][source].with {
    --       generator_opts = {
    --         command = "isort",
    --         args = {
    --           "--stdout",
    --           "--filename",
    --           "$FILENAME",
    --           "--profile",
    --           "black",
    --           "--trailing-comma",
    --           "--lines-between-types",
    --           "1",
    --           "-",
    --         },
    --         to_stdin = true,
    --         cwd = h.cache.by_bufnr(function(params)
    --           return u.root_pattern(
    --             -- isort will detect files in the CWD as first-party
    --             -- https://pycqa.github.io/isort/docs/configuration/config_files.html
    --             ".isort.cfg",
    --             "pyproject.toml",
    --             "setup.py",
    --             "setup.cfg",
    --             "tox.ini",
    --             ".editorconfig"
    --           )(params.bufname)
    --         end),
    --       },
    --     })
    --   end, types)
    -- end,
    mypy = function(source, types)
      -- custom logic
      local overrides = {
        severities = {
          error = h.diagnostics.severities["error"],
          warning = h.diagnostics.severities["warning"],
          note = h.diagnostics.severities["information"],
        },
      }
      vim.tbl_map(function(type)
        null_ls.register(null_ls.builtins[type][source].with {
          generator_opts = {
            command = vim.fn.system(vim.fn.expand "$DOTFILES/bin/which_python.sh mypy"):gsub("^%s*(.-)%s*$", "%1"),
            args = function(params)
              return {
                "--hide-error-codes",
                "--hide-error-context",
                "--no-color-output",
                "--show-absolute-path",
                "--show-column-numbers",
                "--show-error-codes",
                "--no-error-summary",
                "--no-pretty",
                "--shadow-file",
                params.bufname,
                params.temp_path,
                params.bufname,
              }
            end,
            to_temp_file = true,
            format = "line",
            check_exit_code = function(code)
              return code <= 2
            end,
            multiple_files = true,
            on_output = h.diagnostics.from_patterns {
              -- see spec for pattern examples
              {
                pattern = "([^:]+):(%d+):(%d+): (%a+): (.*)  %[([%a-]+)%]",
                groups = { "filename", "row", "col", "severity", "message", "code" },
                overrides = overrides,
              },
              -- no error code
              {
                pattern = "([^:]+):(%d+):(%d+): (%a+): (.*)",
                groups = { "filename", "row", "col", "severity", "message" },
                overrides = overrides,
              },
              -- no column or error code
              {
                pattern = "([^:]+):(%d+): (%a+): (.*)",
                groups = { "filename", "row", "severity", "message" },
                overrides = overrides,
              },
            },
            cwd = h.cache.by_bufnr(function(params)
              return u.root_pattern(
                -- https://mypy.readthedocs.io/en/stable/config_file.html
                "mypy.ini",
                ".mypy.ini",
                "pyproject.toml",
                "setup.cfg"
              )(params.bufname)
            end),
          },
        })
      end, types)
    end,
    prettierd = function(source, types)
      -- custom logic
      vim.tbl_map(function(type)
        null_ls.register(null_ls.builtins[type][source].with {
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "json",
            "jsonc",
            --"yaml",
            --"markdown",
            --"markdown.mdx",
            "graphql",
            "handlebars",
          },
        })
      end, types)
    end,
    sql_formatter = function(source, types)
      -- custom logic
      vim.tbl_map(function(type)
        null_ls.register(null_ls.builtins[type][source].with {
          filetypes = { "mysql", "sql", "plsql" },
          generator_opts = {
            command = "sql-formatter",
            args = {
              "--config",
              vim.fn.expand "$HOME/.sql-formatter.json",
            },
            to_stdin = true,
          },
        })
      end, types)
    end,
    -- sqlfluff = function(source, types)
    -- 	-- custom logic
    -- 	vim.tbl_map(function(type)
    -- 		null_ls.register(null_ls.builtins[type][source].with({
    -- 			filetypes = { "mysql", "sql", "plsql" },
    -- 		}))
    -- 	end, types)
    -- end,
  },
}

null_ls.setup {
  diagnostic_config = {
    virtual_text = false,
  },
  sources = {
    -- null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.hover.printenv,
    -- null_ls.builtins.formatting.xmlformat,
  },
}
