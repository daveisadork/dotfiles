return {
  ensure_installed = {
    "markdown_inline", --Needed for trouble.nvim
  },
  auto_install = true,
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
}
