---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "solarized_dark",

  ---@type Base46HLGroupsList
  hl_override = require "highlights.overrides",
  ---@type HLTable
  hl_add = require "highlights.add",

  tabufline = {
    enabled = true,
    lazyload = false,
    overriden_modules = function(modules)
      modules.buttons = ""
    end,
  },
}

return M
