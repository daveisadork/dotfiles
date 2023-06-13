local utils = require "core.utils"
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local on_attach = function(client, bufnr)
  --client.server_capabilities.documentFormattingProvider = false
  --client.server_capabilities.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

-- lspconfig.diagnosticls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = { "diagnostic-languageserver", "--stdio" },
--   single_file_support = true,
--   init_options = {
--     mergeConfig = true,
--     linters = {
--       ["golangci-lint"] = {
--         command = "golangci-lint",
--         rootPatterns = { ".git", "go.mod" },
--         debounce = 100,
--         args = { "run", "--out-format", "json" },
--         sourceName = "golangci-lint",
--         parseJson = {
--           sourceName = "Pos.Filename",
--           sourceNameFilter = true,
--           errorsRoot = "Issues",
--           line = "Pos.Line",
--           column = "Pos.Column",
--           message = "${Text} [${FromLinter}]",
--         },
--       },
--     },
--     filetypes = {
--       --go = "golangci-lint",
--     },
--     formatters = {
--       golines = {
--         command = "golines",
--         args = {},
--       },
--       black = {
--         command = "black",
--         args = { "--quiet", "-" },
--       },
--       isort = {
--         command = "isort",
--         args = { "--quiet", "-" },
--       },
--       ["goimports-reviser"] = {
--         command = "goimports-reviser",
--         args = {
--           "-output",
--           "stdout",
--           "-company-prefixes",
--           "gitlab.sezzle.com",
--           "%filepath",
--         },
--       },
--     },
--     formatFiletypes = {
--       go = {
--         "golines",
--         -- "goimports-reviser",
--       },
--       python = {
--         "black",
--         "isort",
--       },
--     },
--   },
-- }

-- if you just want default config for the servers then put them in a table
local servers = {
  "clangd",
  "cssls",
  --"diagnosticls",
  "docker_compose_language_service",
  "dockerls",
  "golangci_lint_ls",
  -- "gopls",
  -- "helm_ls",
  "html",
  "jsonls",
  -- "pyright",
  "tsserver",
  --"yamlls",
  "sqlls",
}

lspconfig.yamlls.setup {
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

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls", "-remote=auto" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
  single_file_support = true,
}

lspconfig.helm_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "helm_ls", "serve" },
  filetypes = { "helm" },
  root_dir = lspconfig.util.root_pattern "Chart.yaml",
  single_file_support = true,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
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
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
      pythonPath = vim.fn.system { "pyenv", "which", "python" },
      venvPath = "/Users/david.hayes/.pyenv/versions",
    },
  },
}

-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end

-- lspconfig.pyright.setup { blabla}
