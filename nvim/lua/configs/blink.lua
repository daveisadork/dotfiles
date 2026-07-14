local opts = require "nvchad.blink.config"

opts.keymap.preset = "super-tab"

opts.sources.default = { "lsp", "path", "snippets", "buffer", "lazydev" }
opts.sources.per_filetype = {
  sql = { inherit_defaults = true, "dadbod" },
  mysql = { inherit_defaults = true, "dadbod" },
  plsql = { inherit_defaults = true, "dadbod" },
}
opts.sources.providers = {
  lazydev = {
    name = "LazyDev",
    module = "lazydev.integrations.blink",
    score_offset = 100,
  },
  dadbod = {
    name = "Dadbod",
    module = "vim_dadbod_completion.blink",
  },
}

return opts
