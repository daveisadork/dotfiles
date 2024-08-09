---@type notify.Config
return {
  level = vim.log.levels.TRACE,
  timeout = 3000,
  ---@diagnostic disable-next-line: assign-type-mismatch
  max_width = nil,
  ---@diagnostic disable-next-line: assign-type-mismatch
  max_height = nil,
  stages = "fade_in_slide_out",
  render = "wrapped-compact",
  background_colour = "NotifyBackground",
  ---@diagnostic disable-next-line: assign-type-mismatch
  on_open = nil,
  ---@diagnostic disable-next-line: assign-type-mismatch
  on_close = nil,
  minimum_width = 50,
  fps = 30,
  top_down = true,
  time_formats = {
    notification_history = "%FT%T",
    notification = "%T",
  },
  icons = {
    ERROR = "󰅚",
    WARN = "",
    INFO = "󰋽",
    DEBUG = "",
    TRACE = "",
  },
}
