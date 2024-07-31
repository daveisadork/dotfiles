---@type ChadrcConfig
local M = {}

M.base46 = {
  integrations = {
    "lspsaga",
    "dap",
    "trouble",
  },
  theme = "solarized_dark",
  hl_override = require "highlights.overrides",
  hl_add = require "highlights.add",
}

M.ui = {
  lsp = {
    signature = false,
  },

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
  },

  tabufline = {
    enabled = false,
  },
}

return M
