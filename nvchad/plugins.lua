local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("custom.configs.null-ls")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		cmd = { "LspInstall", "LspUninstall" },
		config = function()
			require("custom.configs.mason-lspconfig")
			--require "plugins.configs.lspconfig"
			--require "custom.configs.lspconfig"
		end, -- Override to setup mason-lspconfig
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		-- config = function()
		--   require "custom.configs.mason-lspconfig"
		--   --require "plugins.configs.lspconfig"
		--   --require "custom.configs.lspconfig"
		-- end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	{
		"hrsh7th/nvim-cmp",
		opts = overrides.nvim_cmp,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				mode = "document_diagnostics",
				auto_close = true,
				use_diagnostic_signs = true,
			})
		end,
	},

	{
		"fatih/vim-go",
		ft = "go",
		config = function()
			require("better_escape").setup()
		end,
		enabled = false,
	},

	{
		"tpope/vim-dadbod",
		cmd = "DB",
	},

	{
		"kristijanhusak/vim-dadbod-completion",
		ft = { "mysql", "sql" },
		dependencies = {
			"tpope/vim-dadbod",
		},
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = "DBUI",
		dependencies = {
			"tpope/vim-dadbod",
		},
		config = function()
			vim.g.db_ui_win_position = "right"
			vim.g.db_ui_winwidth = 60
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_execute_on_save = 1
		end,
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		lazy = false,
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},

	{
		"rest-nvim/rest.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
		},
		lazy = false,
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Keep the http file buffer above|left when split horizontal|vertical
				result_split_in_place = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					show_http_info = true,
					show_headers = true,
					-- executables or functions for formatting response body [optional]
					-- set them to false if you want to disable them
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = ".env",
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})
		end,
	},

	{
		"mfussenegger/nvim-dap",
		lazy = false,
		config = function() end,
	},

	{
		"rcarriga/nvim-dap-ui",
		lazy = false,
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},

	{
		"leoluz/nvim-dap-go",
		lazy = false,
		config = function()
			require("dap-go").setup({
				dap_configurations = {
					{
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
				},
			})
		end,
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = false,
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},

	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			})
		end,
	},

	{
		"vim-airline/vim-airline",
		init = function()
			vim.g.airline_powerline_fonts = 1
			vim.g["airline#extensions#tabline#enabled"] = 1
			vim.g["airline#extensions#tabline#tab_nr_type"] = 1
			vim.g["airline#extensions#tabline#buffer_nr_show"] = 1
			vim.g["airline#extensions#tabline#enabled"] = 1
			vim.g["airline#extensions#tmuxline#enabled"] = 1
			vim.g.airline_theme = "solarline"

			vim.g.airline_left_sep = ""
			vim.g.airline_left_alt_sep = ""
			vim.g.airline_right_sep = ""
			vim.g.airline_right_alt_sep = ""

			vim.g.airline_symbols = {
				crypt = "🔒",
				branch = "",
				readonly = "",
				linenr = "☰",
				maxlinenr = "",
				dirty = " ",
			}
		end,
	},

	{
		"vim-airline/vim-airline-themes",
		dependencies = {
			"vim-airline/vim-airline",
		},
	},

	{
		"edkolev/promptline.vim",
		cmd = {
			"PromplineSnapshot",
		},
		dependencies = {
			"vim-airline/vim-airline",
			"vim-airline/vim-airline-themes",
		},
	},

	{
		"edkolev/tmuxline.vim",
		cmd = {
			"Tmuxline",
			"TmuxlineSimple",
			"TmuxlineSnapshot",
		},
		dependencies = {
			"vim-airline/vim-airline",
			"vim-airline/vim-airline-themes",
		},
		config = function()
			vim.g.tmuxline_preset = "solarline"
			vim.g.tmuxline_theme = "airline"
		end,
	},

	{
		"towolf/vim-helm",
		ft = { "yaml", "helm" },
	},

	{
		"ellisonleao/glow.nvim",
		ft = {
			"markdown",
		},
		cmd = {
			"Glow",
		},
		config = function()
			require("glow").setup()
		end,
	},

	{
		"isobit/vim-caddyfile",
		ft = { "caddyfile" },
	},

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },
}

return plugins
