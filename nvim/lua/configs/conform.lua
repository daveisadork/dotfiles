---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require "conform"
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

local prettier = function(bufnr)
  return { first(bufnr, "prettierd", "prettier"), "injected" }
end

-- This will provide type hinting with LuaLS
---@module "conform"
---@type conform.setupOpts
return {
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    python = function(bufnr)
      return {
        first(bufnr, "ruff_organize_imports", "isort"),
        first(bufnr, "ruff_format", "black"),
        "injected",
      }
    end,
    javascript = prettier,
    javascriptreact = prettier,
    typescript = prettier,
    typescriptreact = prettier,
    vue = prettier,
    css = prettier,
    scss = prettier,
    less = prettier,
    html = prettier,
    json = prettier,
    jsonc = prettier,
    -- yaml = { prettier },
    markdown = { "markdownlint-cli2", "injected" },
    ["markdown.mdx"] = { "markdownlint-cli2", "injected" },
    graphql = prettier,
    handlebars = prettier,
    sql = { "sqlfluff", lsp_format = "fallback" },
  },
}
