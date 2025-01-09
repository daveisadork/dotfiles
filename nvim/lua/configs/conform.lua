local prettier_fts = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "css",
  "scss",
  "less",
  "html",
  "json",
  "jsonc",
  "yaml",
  "markdown",
  "markdown.mdx",
  "graphql",
  "handlebars",
}

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
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "injected", lsp_format = "first" },
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
    -- jsonc = { prettier },
    -- yaml = { prettier },
    -- markdown = { prettier },
    -- ["markdown.mdx"] = { prettier },
    graphql = prettier,
    handlebars = prettier,
    sql = { "sqlfluff", lsp_format = "fallback" },
  },
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
}
