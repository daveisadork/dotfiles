local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")

local b = null_ls.builtins

local sources = {
	b.code_actions.refactoring,
	b.hover.printenv,
	b.diagnostics.misspell.with({
		diagnostic_config = {
			virtual_text = false,
		},
	}),

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
	--b.diagnostics.golangci_lint,
	b.formatting.gofumpt,
	b.formatting.goimports,
	b.code_actions.gomodifytags,
	b.code_actions.impl,

	-- git
	b.diagnostics.gitlint.with({
		diagnostic_config = {
			virtual_text = false,
		},
	}),

	-- sql
	b.formatting.sql_formatter.with({
		filetypes = { "mysql", "sql" },
	}),
	-- b.formatting.sqlfluff.with {
	--   extra_args = { "--dialect", "mysql" },
	--   filetypes = { "mysql", "sql" },
	-- },
}

-- null_ls.setup({
-- 	debug = true,
-- 	sources = sources,
-- })

null_ls.setup({
	debug = true,
	diagnostic_config = {
		virtual_text = false,
	},
	sources = {
		null_ls.builtins.code_actions.refactoring,
		null_ls.builtins.hover.printenv,
	},
})

mason_null_ls.setup({
	ensure_installed = {
		-- misc
		"impl",

		-- go
		"gofumpt",
		"goimports",
		"gomodifytags",
		"golangci_lint",

		-- javascript
		"prettierd",

		-- python
		"black",
		"usort",

		-- lua
		"stylua",
	},
	automatic_installation = false,
	handlers = {
		prettierd = function(source, types)
			-- custom logic
			vim.tbl_map(function(type)
				null_ls.register(null_ls.builtins[type][source].with({
					filetypes = {
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
						--"yaml",
						--"markdown",
						--"markdown.mdx",
						"graphql",
						"handlebars",
					},
				}))
			end, types)
		end,
	},
})
