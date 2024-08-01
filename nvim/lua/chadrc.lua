---@type ChadrcConfig
local M = {

  base46 = {
    integrations = {
      -- "bufferline",
      "dap",
      "lspsaga",
      "trouble",
      "neogit",
    },
    theme = "solarized_dark",
    hl_override = require "highlights.overrides",
    hl_add = require "highlights.add",
  },

  lsp = {
    signature = false,
  },

  ui = {
    cmp = {
      icons = true,
      lspkind_text = true,
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    },

    tabufline = {
      enabled = false,
    },
  },
}

return M
