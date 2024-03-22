-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local mason_lspconfig = require "mason-lspconfig"
local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

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
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function()
    --   require("rust-tools").setup {}
    -- end,

    lua_ls = function()
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,

        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
                [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                [vim.fn.stdpath "data" .. "/lazy/NvChad/lua"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
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
        root_dir = lspconfig.util.root_pattern(
          ".git",
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          "pyrightconfig.json"
        ),
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
            pythonPath = vim.fn.system(vim.fn.expand "$DOTFILES/bin/which_python.sh"):gsub("^%s*(.-)%s*$", "%1"),
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
