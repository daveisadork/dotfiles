local bufferline = require "bufferline"

---@class bufferline.UserConfig
return {
  options = {
    themable = true,
    diagnostics = nil,
    separator_style = "slant",
    style_preset = bufferline.style_preset.no_italic,
  },
}
