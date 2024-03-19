local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
	virtual_text = false,
}, neotest_ns)

require("neotest").setup({
	summary = {
		enabled = true,
		animated = true,
		follow = true,
		expand_errors = true,
		open = "botright vsplit | vertical resize 50",
		mappings = {
			expand = { "<CR>", "<2-LeftMouse>" },
			expand_all = "e",
			output = "o",
			short = "O",
			attach = "a",
			jumpto = "i",
			stop = "u",
			run = "r",
			debug = "d",
			mark = "m",
			run_marked = "R",
			debug_marked = "D",
			clear_marked = "M",
			target = "t",
			clear_target = "T",
			next_failed = "J",
			prev_failed = "K",
		},
	},
	status = {
		enabled = true,
		virtual_text = false,
		signs = true,
	},
	quickfix = {
		enabled = true,
		open = false,
	},
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
		}),
		require("neotest-go")({
			experimental = {
				test_table = true,
			},
		}),
		require("neotest-plenary"),
		require("neotest-vim-test")({
			ignore_file_types = { "go", "python", "vim", "lua" },
		}),
	},
})
