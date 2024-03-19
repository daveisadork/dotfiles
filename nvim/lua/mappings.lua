require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- general
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, { desc = "Diagnostic goto next" })
map("n", "<C-k>", function()
  vim.diagnostic.goto_prev()
end, { desc = "Diagnostic goto prev" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })
map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Continue debugging" })
map("n", "<leader>b", ":DBUI<CR>", { desc = "Open DBUI" })
map("n", "<leader>m", ":Glow<CR>", { desc = "Markdown preview" })
map("n", "<leader>sw", function()
  if vim.opt.list then
    vim.opt.list = false
  else
    vim.opt.listchars = { tab = "——→", eol = "↵", space = "·" }
    vim.opt.list = true
  end
end, { desc = "Toggle whitespace" })
map("v", "<S-Tab>", "<gv", { desc = "Unindent" })
map("v", "<Tab>", ">gv", { desc = "Indent" })

--telescope
map("n", "<C-p>", ":Telescope find_files <CR>", { desc = "Telescope Files" })
-- map("n", "gi", ":Telescope lsp_implementations<CR>", { desc = "LSP Implementations" })
-- map("n", "gr", ":Telescope lsp_references<CR>", { desc = "LSP References" })
-- map("n", "gd", ":Telescope lsp_definitions<CR>", { desc = "LSP Definitions" })
-- map("n", "gt", ":Telescope lsp_type_definitions<CR>", { desc = "LSP Type Definitions" })
map("n", "<leader>fs", ":Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "LSP Workspace Symbols" })

-- rest
map("n", "<leader>rq", "<Plug>RestNvim", { desc = "RestNvim run the request under the cursor" })
map("n", "<leader>rp", "<Plug>RestNvimPreview", { desc = "RestNvim preview the request cURL command" })
map("n", "<leader>rr", "<Plug>RestNvimLast", { desc = "RestNvim re-run the last request" })

--trouble
map("n", "gi", ":Trouble lsp_implementations<CR>", { desc = "LSP Implementations" })
map("n", "gr", ":Trouble lsp_references<CR>", { desc = "LSP References" })
map("n", "gd", ":Trouble lsp_definitions<CR>", { desc = "LSP Definitions" })
map("n", "gt", ":Trouble lsp_type_definitions<CR>", { desc = "LSP Type Definitions" })
map("n", "<leader>tt", ":TroubleToggle<CR>", { desc = "Toggle Trouble" })

-- nvterm
map("t", "<C-t>", function()
  require("nvterm.terminal").toggle "float"
end, { desc = "toggle floating term" })
map("t", "<leader>h", function()
  require("nvterm.terminal").toggle "horizontal"
end, { desc = "toggle horizontal term" })
map("n", "<C-t>", function()
  require("nvterm.terminal").toggle "float"
end, { desc = "toggle floating term" })
map("n", "<leader>h", function()
  require("nvterm.terminal").toggle "horizontal"
end, { desc = "toggle horizontal term" })

-- neotest
map("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand "%")
end, { desc = "run test file" })
map("n", "<leader>tn", function()
  require("neotest").run.run()
end, { desc = "run nearest test" })
map("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "test summary" })
map("n", "<leader>tb", function()
  require("neotest").run.run { strategy = "dap" }
end, { desc = "debug nearest test" })
map("n", "<leader>ta", function()
  require("neotest").run.attach()
end, { desc = "attach to nearest test" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
