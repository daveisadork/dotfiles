-- EXAMPLE
local nv_on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local mason_lspconfig = require "mason-lspconfig"
local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local servers = { "html", "cssls" }

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

local function on_attach(client, bufnr)
  nv_on_attach(client, bufnr)
  -- your custom attach code
  vim.diagnostic.config {
    virtual_text = false,
    float = {
      border = "single",
      source = true,
    },
  }

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
  })

  lspSymbol("Error", "󰅚")
  lspSymbol("Info", "󰋽")
  lspSymbol("Hint", "󰛩")
  lspSymbol("Warn", "")
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- -- typescript
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }

local python_root = lspconfig.util.root_pattern(
  "pyproject.toml",
  "setup.cfg",
  "requirements.txt",
  "setup.py",
  "Pipfile",
  "pyrightconfig.json",
  ".git"
)

local python_path = vim.fn.system(vim.fn.expand "$DOTFILES/bin/which_python.sh"):gsub("^%s*(.-)%s*$", "%1")

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
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      }
    end,

    yamlls = function()
      lspconfig.yamlls.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
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
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        cmd = { "gopls", "-remote=auto", "-remote.listen.timeout", "5s" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
        single_file_support = true,
      }
    end,

    helm_ls = function()
      lspconfig.helm_ls.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        cmd = { "helm_ls", "serve" },
        filetypes = { "helm" },
        root_dir = lspconfig.util.root_pattern "Chart.yaml",
        single_file_support = true,
      }
    end,

    pyright = function()
      lspconfig.pyright.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_dir = python_root,
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
            pythonPath = python_path,
          },
        },
      }
    end,

    basedpyright = function()
      lspconfig.basedpyright.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        cmd = { "basedpyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_dir = python_root,
        single_file_support = true,
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic",
            },
          },
          python = {
            pythonPath = python_path,
          },
        },
      }
    end,

    pylsp = function()
      lspconfig.pylsp.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        cmd = { "pylsp" },
        filetypes = { "python" },
        root_dir = python_root,
        single_file_support = true,
        settings = {
          pylsp = {
            plugins = {
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
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "nginx-language-server" },
    filetypes = { "nginx" },
    root_dir = lspconfig.util.root_pattern "nginx.conf",
    single_file_support = true,
  },
}

lspconfig.nginx_ls.setup {}
