local lspconfig = require "lspconfig"

local map = vim.keymap.set

local M = {}

M.python_root = lspconfig.util.root_pattern(
  "pyproject.toml",
  "setup.cfg",
  "requirements.txt",
  "setup.py",
  "Pipfile",
  "pyrightconfig.json",
  ".git"
)

M.python_path = function()
  return vim.fn.system(vim.fn.expand "$DOTFILES/bin/which_python.sh"):gsub("^%s*(.-)%s*$", "%1")
end

-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

  -- map("n", "<leader>ra", function()
  --   require "nvchad.lsp.renamer"()
  -- end, opts "NvRenamer")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true)
  end
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  M.capabilities = vim.tbl_deep_extend("force", M.capabilities, cmp_nvim_lsp.default_capabilities())
end

dofile(vim.g.base46_cache .. "lsp")
return {
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

-- lspconfig.nginx_ls.setup {}

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
