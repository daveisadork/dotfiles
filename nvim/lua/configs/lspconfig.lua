-- EXAMPLE
local nvchad_lspconfig = require "nvchad.configs.lspconfig"

local mason_lspconfig = require "mason-lspconfig"
local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"

local M = {
  capabilities = nvchad_lspconfig.capabilities,
  on_init = nvchad_lspconfig.on_init,
  python_root = lspconfig.util.root_pattern(
    "pyproject.toml",
    "setup.cfg",
    "requirements.txt",
    "setup.py",
    "Pipfile",
    "pyrightconfig.json",
    ".git"
  ),
  python_path = function()
    return vim.fn.system(vim.fn.expand "$DOTFILES/bin/which_python.sh"):gsub("^%s*(.-)%s*$", "%1")
  end,

  diagnostic_config = function()
    local dc = {
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "󰋽",
          [vim.diagnostic.severity.HINT] = "󰛩",
        },
      },
      underline = true,
      float = { border = "single", source = true },
    }
    vim.diagnostic.config(dc)

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, dc)
  end,
}

M.on_attach = function(client, bufnr)
  -- nvchad_lspconfig.on_attach(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true)
  end
end

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  -- nvchad_lspconfig.defaults()
  M.diagnostic_config()
  mason_lspconfig.setup {
    ensure_installed = {
      --"gopls",
      --"golangci_lint_ls",
      --"helm_ls",
      --"lua_ls",
      --"pyright",
      --"tsserver",
      --"yaml_ls",
    },
    handlers = {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server_name) -- default handler (optional)
        lspconfig[server_name].setup {
          on_attach = M.on_attach,
          on_init = M.on_init,
          capabilities = M.capabilities,
        }
      end,

      yamlls = function()
        lspconfig.yamlls.setup {
          on_attach = M.on_attach,
          on_init = M.on_init,
          capabilities = M.capabilities,
          cmd = { "yaml-language-server", "--stdio" },
          filetypes = { "yaml", "yaml.docker-compose" },
          root_dir = lspconfig.util.find_git_ancestor,
          settings = {
            redhat = {
              telemetry = {
                enabled = false,
              },
            },
            yaml = {
              keyOrdering = false,
            },
          },
          single_file_support = true,
        }
      end,

      gopls = function()
        lspconfig.gopls.setup {
          on_attach = M.on_attach,
          on_init = M.on_init,
          capabilities = M.capabilities,
          cmd = { "gopls", "-remote=auto", "-remote.listen.timeout", "5s" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
          single_file_support = true,
        }
      end,

      helm_ls = function()
        lspconfig.helm_ls.setup {
          on_attach = M.on_attach,
          on_init = M.on_init,
          capabilities = M.capabilities,
          cmd = { "helm_ls", "serve" },
          filetypes = { "helm" },
          root_dir = lspconfig.util.root_pattern "Chart.yaml",
          single_file_support = true,
        }
      end,

      pyright = function()
        lspconfig.pyright.setup {
          on_attach = M.on_attach,
          on_init = M.on_init,
          capabilities = M.capabilities,
          cmd = { "pyright-langserver", "--stdio" },
          filetypes = { "python" },
          root_dir = M.python_root,
          single_file_support = true,
          settings = {
            pyright = {
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "basic",
              },
              pythonPath = M.python_path(),
            },
          },
        }
      end,

      basedpyright = function()
        lspconfig.basedpyright.setup {
          on_attach = M.on_attach,
          on_init = M.on_init,
          capabilities = M.capabilities,
          cmd = { "basedpyright-langserver", "--stdio" },
          filetypes = { "python" },
          root_dir = M.python_root,
          single_file_support = true,
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                -- diagnosticMode = "workspace",
                typeCheckingMode = "basic",
                diagnosticSeverityOverrides = {
                  reportUnusedImport = "none",
                },
              },
            },
            python = {
              pythonPath = M.python_path(),
            },
          },
        }
      end,

      pylsp = function()
        lspconfig.pylsp.setup {
          on_attach = M.on_attach,
          on_init = M.on_init,
          capabilities = M.capabilities,
          cmd = { "pylsp" },
          filetypes = { "python" },
          root_dir = M.python_root,
          single_file_support = true,
          settings = {
            pylsp = {
              plugins = {
                jedi_completion = {
                  enabled = false,
                },
                jedi_hover = {
                  enabled = false,
                },
                jedi_signature_help = {
                  enabled = false,
                },
                jedi_symbols = {
                  enabled = false,
                },
                rope_completion = {
                  enabled = false,
                },
                autopep8 = {
                  enabled = false,
                },
                black = {
                  enabled = false,
                },
                flake8 = {
                  enabled = false,
                },
                isort = {
                  enabled = false,
                },
                mccabe = {
                  enabled = false,
                },
                pycodestyle = {
                  enabled = false,
                },
                pydocstyle = {
                  enabled = false,
                },
                pyflakes = {
                  enabled = false,
                },
                pylint = {
                  enabled = false,
                },
                yapf = {
                  enabled = false,
                },
              },
            },
          },
        }
      end,
    },
  }

  configs.nginx_ls = {
    default_config = {
      on_attach = M.on_attach,
      on_init = M.on_init,
      capabilities = M.capabilities,
      cmd = { "nginx-language-server" },
      filetypes = { "nginx" },
      root_dir = lspconfig.util.root_pattern "nginx.conf",
      single_file_support = true,
    },
  }

  lspconfig.nginx_ls.setup {}

  -- lspconfig.lua_ls.setup {
  --   on_attach = M.on_attach,
  --   capabilities = M.capabilities,
  --   on_init = M.on_init,
  --
  --   settings = {
  --     Lua = {
  --       diagnostics = {
  --         globals = { "vim" },
  --       },
  --       workspace = {
  --         library = {
  --           vim.fn.expand "$VIMRUNTIME/lua",
  --           vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
  --           vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
  --           vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
  --         },
  --         maxPreload = 100000,
  --         preloadFileSize = 10000,
  --       },
  --     },
  --   },
  -- }
end

return M
