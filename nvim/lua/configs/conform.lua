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

local prettier_configs = {
  ".prettierrc",
  ".prettierrc.json",
  ".prettierrc.yml",
  ".prettierrc.yaml",
  ".prettierrc.json5",
  ".prettierrc.js",
  ".prettierrc.cjs",
  ".prettierrc.mjs",
  ".prettierrc.toml",
  "prettier.config.js",
  "prettier.config.cjs",
  "prettier.config.mjs",
  "prettier.config.ts",
}

local function nearest_config_dir(bufnr, names)
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local found = vim.fs.find(names, { path = filepath, upward = true })[1]
  return found and vim.fs.dirname(found)
end

-- Use biome only when its config is at least as close as any prettier config.
-- In a monorepo, a .prettierrc in a child package beats a biome.json higher up.
local function use_biome(bufnr)
  local biome_dir = nearest_config_dir(bufnr, { "biome.json", "biome.jsonc" })
  if not biome_dir then return false end
  local prettier_dir = nearest_config_dir(bufnr, prettier_configs)
  return not prettier_dir or #biome_dir >= #prettier_dir
end

local prettier = function(bufnr)
  return { first(bufnr, "prettierd", "prettier"), "injected" }
end

-- biome supports: js, ts, jsx, tsx, json, jsonc, css, graphql
-- does NOT support: vue, scss, less, html, handlebars
local biome_or_prettier = function(bufnr)
  if use_biome(bufnr) then
    return { "biome", "injected" }
  end
  return prettier(bufnr)
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
    javascript = biome_or_prettier,
    javascriptreact = biome_or_prettier,
    typescript = biome_or_prettier,
    typescriptreact = biome_or_prettier,
    vue = prettier,
    css = biome_or_prettier,
    scss = prettier,
    less = prettier,
    html = prettier,
    json = biome_or_prettier,
    jsonc = biome_or_prettier,
    -- yaml = { prettier },
    markdown = { "markdownlint-cli2", "injected" },
    ["markdown.mdx"] = { "markdownlint-cli2", "injected" },
    graphql = biome_or_prettier,
    handlebars = prettier,
    sql = { "sqlfluff", lsp_format = "fallback" },
  },
}
