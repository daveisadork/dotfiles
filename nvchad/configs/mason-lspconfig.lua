dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp")

local utils = require("core.utils")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local capabilities = require("plugins.configs.lspconfig").capabilities
local on_attach = require("plugins.configs.lspconfig").on_attach

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- capabilities.textDocument.completion.completionItem = {
-- 	documentationFormat = { "markdown", "plaintext" },
-- 	snippetSupport = true,
-- 	preselectSupport = true,
-- 	insertReplaceSupport = true,
-- 	labelDetailsSupport = true,
-- 	deprecatedSupport = true,
-- 	commitCharactersSupport = true,
-- 	tagSupport = { valueSet = { 1 } },
-- 	resolveSupport = {
-- 		properties = {
-- 			"documentation",
-- 			"detail",
-- 			"additionalTextEdits",
-- 		},
-- 	},
-- }
--
-- local on_attach = function(client, bufnr)
-- 	utils.load_mappings("lspconfig", { buffer = bufnr })
--
-- 	if client.server_capabilities.signatureHelpProvider then
-- 		require("nvchad_ui.signature").setup(client)
-- 	end
--
-- 	if not utils.load_config().ui.lsp_semantic_tokens then
-- 		client.server_capabilities.semanticTokensProvider = nil
-- 	end
-- end

mason_lspconfig.setup({
  ensure_installed = {
    "gopls",
    --"golangci_lint_ls",
    "helm_ls",
    "lua_ls",
    -- "pyright",
    "tsserver",
    "yamlls",
  },
  handlers = {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function()
    --   require("rust-tools").setup {}
    -- end,

    lua_ls = function()
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,

        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                [vim.fn.stdpath("data") .. "/lazy/extensions/nvchad_types"] = true,
                [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      })
    end,

    yamlls = function()
      lspconfig.yamlls.setup({
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
      })
    end,

    gopls = function()
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "gopls", "-remote=auto", "-remote.listen.timeout", "5s" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
        single_file_support = true,
      })
    end,

    helm_ls = function()
      lspconfig.helm_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "helm_ls", "serve" },
        filetypes = { "helm" },
        root_dir = lspconfig.util.root_pattern("Chart.yaml"),
        single_file_support = true,
      })
    end,

    pyright = function()
      lspconfig.pyright.setup({
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
            pythonPath = vim.fn
                .system(vim.fn.expand("$DOTFILES/bin/which_python.sh"))
                :gsub("^%s*(.-)%s*$", "%1"),
            -- pythonPath = vim.fn.system({ "pyenv", "which", "python" }):gsub("^%s*(.-)%s*$", "%1"),
          },
        },
      })
    end,
  },
})

configs.nginx_ls = {
  default_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "nginx-language-server" },
    filetypes = { "nginx" },
    root_dir = lspconfig.util.root_pattern("nginx.conf"),
    single_file_support = true,
  },
}

lspconfig.nginx_ls.setup({})
