local prettier = { "prettierd", "prettier", stop_after_first = true }
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

return {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
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
    -- sql = { "sqlfluff" },
  },
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
}
