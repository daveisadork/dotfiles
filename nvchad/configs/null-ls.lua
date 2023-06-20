local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  b.code_actions.refactoring,
  b.hover.printenv,

  -- webdev stuff
  -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  --b.formatting.prettierd.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
  b.formatting.prettierd,

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- python
  b.formatting.black,
  b.formatting.isort,

  -- go
  --b.formatting.golines,
  b.formatting.goimports,
  b.code_actions.gomodifytags,
  b.code_actions.impl,
  b.diagnostics.commitlint,

  -- sql
  b.formatting.sqlfluff.with {
    extra_args = { "--dialect", "postgres" },
    filetypes = { "mysql", "sql" },
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
