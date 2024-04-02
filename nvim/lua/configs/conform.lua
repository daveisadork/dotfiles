return {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { { "prettierd", "prettier" } },
    -- html = { { "prettierd", "prettier" } },
    -- javascript = { { "prettierd", "prettier" } },
    -- python = function(bufnr)
    --   if require("conform").get_formatter_info("ruff_format", bufnr).available then
    --     return { "ruff_format" }
    --   else
    --     return { "isort", "black" }
    --   end
    -- end,
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}
