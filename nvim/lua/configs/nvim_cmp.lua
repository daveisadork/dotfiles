local opts = require "nvchad.configs.cmp"
cmp = require "cmp"

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
end

opts.mapping["<Tab>"] = vim.schedule_wrap(function(fallback)
  if cmp.visible() and has_words_before() then
    cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
  else
    fallback()
  end
end)

opts.sources = {
  { name = "copilot", group_index = 2 },
  -- { name = "nvim_lsp_signature_help" },
  { name = "nvim_lsp" },
  --{ name = "luasnip" },
  { name = "nvim_lua" },
  { name = "path" },
  { name = "buffer", group_index = 2 },
}

return opts
