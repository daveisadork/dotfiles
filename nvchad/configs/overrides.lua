local M = {}

M.blankline = {
	indentLine_enabled = 1,
	filetype_exclude = {
		"help",
		"terminal",
		"lazy",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"mason",
		"nvdash",
		"nvcheatsheet",
		"",
	},
	buftype_exclude = { "terminal" },
	show_trailing_blankline_indent = false,
	show_first_indent_level = true,
	show_current_context = true,
	show_current_context_start = true,
}

M.treesitter = {
	ensure_installed = {},
	auto_install = true,
	highlight = {
		enable = true,
		use_languagetree = true,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
		disable = { "python" },
	},
}

M.mason = {
	ensure_installed = {
		-- "lua-language-server",
		-- "yaml-language-server",
		-- "gopls",
		-- "helm-ls",
		-- "pyright",

		-- "prettierd",
		-- "black",

		-- "css-lsp",
		-- "docker-compose-language-service",
		-- "dockerfile-language-server",
		-- "go-debug-adapter",
		-- "html-lsp",
		-- "json-lsp",
		-- "nginx-language-server",
		-- "prettier",
		-- "sqlls",
		-- "stylua",
		-- "typescript-language-server",
		-- "vim-language-server",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

M.telescope = {
	defaults = require("plugins.configs.telescope").defaults,
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = false,
		},
	},
	extensions_list = {
		"fzf",
		"fzy_native",
		"terms",
		"themes",
	},
}

M.nvim_cmp = {
	sources = {
		{ name = "nvim_lsp" },
		--{ name = "luasnip" },
		--{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	},
}

return M
