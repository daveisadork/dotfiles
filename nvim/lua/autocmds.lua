require "nvchad.autocmds"

-- Clear the arglist after startup so :q doesn't complain with
-- "E173: N more files to edit" when launched with multiple files.
-- The files still open as buffers (:bn / :bp to cycle).
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() > 1 then
      vim.cmd "%argdelete"
    end
  end,
})
