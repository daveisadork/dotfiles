-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.g.mapleader = ","
vim.wo.wrap = false
vim.opt.listchars = {
	tab = "——→",
	eol = "↵",
	space = "·",
}
vim.opt.list = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.ruler = true
vim.opt.whichwrap = ""
vim.opt.showtabline = 2

vim.api.nvim_create_autocmd("FileType", {
	pattern = "css,eruby,html,javascript,jinja.html,json,ruby,scss,typescript,vim,yaml,zsh,typescript.tsx,javascript.jsx,typescriptreact,lua",
	callback = function()
		vim.opt.shiftwidth = 2
		vim.opt.tabstop = 2
		vim.opt.softtabstop = 2
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.opt.expandtab = false
	end,
})

-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "dbout",
	callback = function()
		vim.opt_local.foldenable = false
		vim.opt_local.signcolumn = "no"
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
})

--vim.api.nvim_create_autocmd("FileType", {
--  pattern = "python",
--  callback = function()
--    local pypath = vim.fn.system({"pyenv", "which", "python"})
--    vim.cmd(":PyrightSetPythonPath " .. pypath)
--  end,
--})
