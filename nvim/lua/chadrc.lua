---@type ChadrcConfig
local M = {}

M.base46 = {
  integrations = {
    "lspsaga",
  },
}

M.ui = {
  theme = "solarized_dark",

  ---@type Base46HLGroupsList
  hl_override = require "highlights.overrides",
  ---@type HLTable
  hl_add = require "highlights.add",

  lsp = {
    signature = false,
  },

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
  },

  tabufline = {
    enabled = true,
    lazyload = false,
    overriden_modules = function(modules)
      modules.buttons = ""
    end,
  },
}

return M
