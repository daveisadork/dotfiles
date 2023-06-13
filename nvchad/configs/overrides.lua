local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "c",
    "css",
    "dockerfile",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "vimdoc",
    "html",
    "http",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "sql",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

M.mason = {
  ensure_installed = {
    "css-lsp",
    "deno",
    "diagnostic-language-server",
    "docker-compose-language-service",
    "dockerfile-language-server",
    "go-debug-adapter",
    "golang-lint-langserver",
    "gopls",
    "html-lsp",
    "json-lsp",
    "lua-language-server",
    "nginx-language-server",
    "prettier",
    "sqlls",
    "stylua",
    "typescript-language-server",
    "vim-language-server",
    "yaml-language-server",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.telescope = {}

return M
