---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "solarized_dark",

  ---@type Base46HLGroupsList
  hl_override = {
    Visual = {
      bg = "light_bg2",
    },
    CursorLine = {
      bg = "black2",
    },
    Comment = {
      italic = true,
    },
    ["@comment"] = { italic = true },
  },

  ---@type HLTable
  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
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
