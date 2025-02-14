require "nvchad.options"

-- set in init.lua
-- vim.keymap.set("", "<Space>", "<Nop>", { silent = true, noremap = true })
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

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
vim.opt.confirm = false
vim.g.copilot_no_tab_map = true
vim.o.cursorlineopt = "both"
vim.o.relativenumber = true
vim.opt.smartindent = false
vim.o.signcolumn = "yes"
vim.o.foldenable = false

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
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neotest-summary",
  callback = function()
    vim.opt_local.list = false
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  pattern = { "qf", "dbui", "dbout", "httpResult", "neotest-summary" },
  command = [[if winnr('$') == 1 |q|endif]],
})

vim.filetype.add {
  filename = { [".sqlfluff"] = "ini" },
  pattern = { ["Dockerfile.*"] = "dockerfile" },
}

---@type vim.diagnostic.Opts
local diagnostic_config = {
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "󰋽",
      [vim.diagnostic.severity.HINT] = "󰛩",
    },
  },
  underline = true,
  float = { border = "single", source = true },
}

vim.diagnostic.config(diagnostic_config)
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostic_config)
