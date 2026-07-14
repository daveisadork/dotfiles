local lspconfig = require "lspconfig"

local map = vim.keymap.set

vim.lsp.handlers["client/registerCapability"] = (function(overridden)
  return function(err, res, ctx)
    local result = overridden(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
      return
    end
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
    -- if client.supports_method "textDocument/semanticTokens" then
    --   client.server_capabilities.semanticTokensProvider = nil
    -- end
    return result
  end
end)(vim.lsp.handlers["client/registerCapability"])

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end
    local bufnr = ev.buf
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

    map("n", "<leader>ra", function()
      require "nvchad.lsp.renamer"()
    end, opts "NvRenamer")

    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    map("n", "gr", vim.lsp.buf.references, opts "Show references")
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

dofile(vim.g.base46_cache .. "lsp")

vim.lsp.config("basedpyright", {
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
    -- python = {
    --   pythonPath = M.python_path(),
    -- },
  },
})

vim.lsp.config("pyright", {
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
      -- pythonPath = M.python_path(),
    },
  },
})

vim.lsp.config("yamlls", {
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

vim.lsp.config("biome", {
  -- hack to disable go to definition for biome, since it doesn't work properly
  handlers = {
    ["client/registerCapability"] = function(err, res, ctx)
      if res and res.registrations then
        for i, reg in ipairs(res.registrations) do
          if reg.method ~= "textDocument/definition" then
            table.remove(res.registrations, i)
            break
          end
        end
      end
      return vim.lsp.handlers["client/registerCapability"](err, res, ctx)
    end,
  },
})

return {
  automatic_enable = true,
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
