---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<C-p>"] = { ":Telescope find_files <CR>", "Telescope Files" },
		["<C-j>"] = {
			function()
				vim.diagnostic.goto_next()
			end,
			"Diagnostic goto next",
		},
		["<C-k>"] = {
			function()
				vim.diagnostic.goto_prev()
			end,
			"Diagnostic goto prev",
		},
		["<leader>rq"] = { "<Plug>RestNvim", "RestNvim run the request under the cursor" },
		["<leader>rp"] = { "<Plug>RestNvimPreview", "RestNvim preview the request cURL command" },
		["<leader>rr"] = { "<Plug>RestNvimLast", "RestNvim re-run the last request" },
		["<leader>db"] = {
			function()
				require("dap").toggle_breakpoint()
			end,
			"Toggle breakpoint",
		},
		["<leader>dc"] = {
			function()
				require("dap").continue()
			end,
			"Continue debugging",
		},
		-- ["gi"] = { ":Trouble lsp_implementations<CR>", "LSP Implementations" },
		-- ["gr"] = { ":Trouble lsp_references<CR>", "LSP References" },
		-- ["gd"] = { ":Trouble lsp_definitions<CR>", "LSP Definitions" },
		-- ["gt"] = { ":Trouble lsp_type_definitions<CR>", "LSP Type Definitions" },
		["<leader>tt"] = { ":TroubleToggle<CR>", "Toggle Trouble" },
		["<leader>b"] = { ":DBUI<CR>", "Open DBUI" },
		["<leader>m"] = { ":Glow<CR>", "Markdown preview" },
		["<leader>sw"] = {
			function()
				if vim.opt.list then
					vim.opt.list = false
				else
          vim.opt.listchars = { tab = "——→", eol = "↵", space = "·" }
					vim.opt.list = true
				end
			end,
			"Toggle whitespace",
		},
	},
	v = {
		["<S-Tab>"] = { "<gv", "Unindent" },
		["<Tab>"] = { ">gv", "Indent" },
	},
}

M.nvterm = {
	plugin = true,
	t = {
		-- toggle in terminal mode
		["<C-t>"] = {
			function()
				require("nvterm.terminal").toggle("float")
			end,
			"toggle floating term",
		},
		["<leader>h"] = {
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			"toggle horizontal term",
		},
	},
	n = {
		-- toggle in normal mode
		["<C-t>"] = {
			function()
				require("nvterm.terminal").toggle("float")
			end,
			"toggle floating term",
		},
		["<leader>h"] = {
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			"toggle horizontal term",
		},
	},
}

M.neotest = {
	plugin = true,
	n = {
		["<leader>tf"] = {
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			"run test file",
		},
		["<leader>tn"] = {
			function()
				require("neotest").run.run()
			end,
			"run nearest test",
		},
		["<leader>ts"] = {
			function()
				require("neotest").summary.toggle()
			end,
			"test summary",
		},
		["<leader>tb"] = {
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			"debug nearest test",
		},
		["<leader>ta"] = {
			function()
				require("neotest").run.attach()
			end,
			"attach to nearest test",
		},
	},
}
-- more keybinds!

return M
