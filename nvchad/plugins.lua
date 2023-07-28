local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

  {

    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
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
		},
		-- config = function()
		--   require "custom.configs.mason-lspconfig"
		--   --require "plugins.configs.lspconfig"
		--   --require "custom.configs.lspconfig"
		-- end, -- Override to setup mason-lspconfig
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("custom.configs.null-ls")
		end,
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
		cmd = {
			"Trouble",
			"TroubleClose",
			"TroubleRefresh",
			"TroubleToggle",
		},
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
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
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
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			vim.g.db_ui_win_position = "right"
			vim.g.db_ui_winwidth = 60
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_execute_on_save = 1
		end,
	},

	{
		"nvim-telescope/telescope-fzy-native.nvim",
		build = "cd deps/fzy-lua-native && make all",
		event = "BufRead",
		--config = function()
		--	require("telescope").load_extension("fzy")
		--end,
	},

	{
		"rest-nvim/rest.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		ft = { "http" },
		init = function()
			require("core.utils").load_mappings("rest")
		end,
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

	-- {
	-- 	"mfussenegger/nvim-dap",
	-- 	lazy = false,
	-- 	config = function() end,
	-- },

	{
		"jay-babu/mason-nvim-dap.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
			{
				"theHamsta/nvim-dap-virtual-text",
				config = function()
					require("nvim-dap-virtual-text").setup()
				end,
			},
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "python", "delve" },
				handlers = {
					function(config)
						-- all sources with no handler get passed here

						-- Keep original functionality
						require("mason-nvim-dap").default_setup(config)
					end,
					delve = function(config)
						table.insert(config.configurations, {
							type = "delve",
							name = "Delve: Debug with args",
							request = "launch",
							program = "${file}",
							args = function()
								local argument_string = vim.fn.input("Program arguments: ")
								return vim.fn.split(argument_string, " ", true)
							end,
						})
						require("mason-nvim-dap").default_setup(config)
					end,
				}, -- sets up dap in the predefined manner
			})
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		init = function()
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

	-- {
	-- 	"leoluz/nvim-dap-go",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("dap-go").setup({
	-- 			dap_configurations = {
	-- 				{
	-- 					type = "go",
	-- 					name = "Attach remote",
	-- 					mode = "remote",
	-- 					request = "attach",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },

	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({
				library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
			})
		end,
	},

	{
		"vim-airline/vim-airline",
		enabled = false,
		init = function()
			vim.g.airline_powerline_fonts = 1
			vim.g["airline#extensions#tabline#enabled"] = 1
			vim.g["airline#extensions#tabline#tab_nr_type"] = 1
			vim.g["airline#extensions#tabline#buffer_nr_show"] = 1
			vim.g["airline#extensions#tabline#enabled"] = 1
			vim.g["airline#extensions#tmuxline#enabled"] = 1
			vim.g.airline_theme = "solarline"

			--vim.g.airline_left_sep = ""
			--vim.g.airline_left_alt_sep = ""
			--vim.g.airline_right_sep = ""
			--vim.g.airline_right_alt_sep = ""

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
		config = function()
			vim.cmd([[
        let g:promptline_preset = {
          \ 'a'    : [ promptline#slices#python_virtualenv() ],
          \ 'b'    : [ '$USER' ],
          \ 'c'    : [ '%~' ],
          \ 'x'    : [ promptline#slices#vcs_branch() ],
          \ 'y'    : [ promptline#slices#host({ 'only_if_ssh': 1  }) ],
          \ 'z'    : [],
          \ 'warn' : [ promptline#slices#last_exit_code() ],
          \ 'options': {
               \ 'left_sections' : [ 'y', 'b', 'a', 'x', 'c', 'z', 'warn' ],
               \ 'right_sections': []}}
      ]])
		end,
	},

	{
		"edkolev/tmuxline.vim",
		cmd = {
			"Tmuxline",
			"TmuxlineSimple",
			"TmuxlineSnapshot",
		},
		config = function()
			require("custom.configs.tmuxline")
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
	{
		"nvim-neotest/neotest",
		init = function()
			require("core.utils").load_mappings("neotest")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-vim-test",
		},
		config = function()
			require("custom.configs.neotest")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		opts = overrides.blankline,
	},
	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },
}

return plugins
