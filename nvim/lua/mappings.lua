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

-- telescope
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

-- trouble
-- map("n", "gi", ":Trouble lsp_implementations<CR>", { desc = "LSP Implementations" })
-- map("n", "gr", ":Trouble lsp_references<CR>", { desc = "LSP References" })
-- map("n", "gd", ":Trouble lsp_definitions<CR>", { desc = "LSP Definitions" })
-- map("n", "gt", ":Trouble lsp_type_definitions<CR>", { desc = "LSP Type Definitions" })
-- map("n", "<leader>tt", ":TroubleToggle<CR>", { desc = "Toggle Trouble" })

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
-- map("n", "<leader>ts", function()
--   require("neotest").summary.toggle()
-- end, { desc = "toggle test summary" })
--
-- map("n", "<leader>to", function()
--   require("neotest").output.open()
-- end, { desc = "show test output" })
--
-- map("n", "<leader>tp", function()
--   require("neotest").output_panel.toggle()
-- end, { desc = "toggle test output panel" })
--
-- map("n", "<leader>t<cr>", function()
--   local neotest = require "neotest"
--   neotest.run.run(vim.fn.expand "%")
--   neotest.summary.open()
-- end, { desc = "run test file" })
--
-- map("n", "<leader>tn", function()
--   local neotest = require "neotest"
--   neotest.run.run()
--   neotest.summary.open()
-- end, { desc = "run nearest test" })
--
-- map("n", "<leader>tl", function()
--   require("neotest").run.run_last()
-- end, { desc = "run last test(s)" })
--
-- map("n", "<leader>tt", function()
--   local neotest = require "neotest"
--   neotest.run.run { suite = true }
--   neotest.summary.open()
-- end, { desc = "run test suite" })
--
-- map("n", "<leader>tk", function()
--   require("neotest").run.stop()
-- end, { desc = "stop running test(s)" })
--
-- map("n", "<leader>tb", function()
--   require("neotest").run.run { strategy = "dap" }
-- end, { desc = "debug nearest test" })
--
-- map("n", "<leader>ta", function()
--   require("neotest").run.attach()
-- end, { desc = "attach to nearest test" })
--
-- map("n", "<leader>twf", function()
--   require("neotest").watch.toggle(vim.fn.expand "%")
-- end, { desc = "watch test file" })
--
-- map("n", "<leader>twn", function()
--   require("neotest").watch.toggle()
-- end, { desc = "watch nearest test" })
--
-- map("n", "<leader>twt", function()
--   require("neotest").watch.toggle { suite = true }
-- end, { desc = "watch test suite" })
--
-- map("n", "<leader>fn", function()
--   require("neotest").jump.next { status = "failed" }
-- end, { desc = "jump to next failed test" })
--
-- map("n", "<leader>fp", function()
--   require("neotest").jump.prev { status = "failed" }
-- end, { desc = "jump to previous failed test" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- local function lspSymbol(name, icon)
--   local hl = "DiagnosticSign" .. name
--   vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
-- end
--
-- lspSymbol("Error", "󰅚")
-- lspSymbol("Info", "󰋽")
-- lspSymbol("Hint", "󰛩")
-- lspSymbol("Warn", "")
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   virtual_text = false,
-- })
