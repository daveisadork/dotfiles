"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Use neovim specific solarized
Plug 'iCyMind/NeoSolarized'

" Plug 'jacobsimpson/nvim-example-python-plugin'
" Test running
Plug 'janko-m/vim-test'

" Airline/tmux/zsh
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'

" Code visualization stuff
Plug 'lilydjwg/colorizer'
Plug 'luochen1990/rainbow'

" Utility stuff
Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-surround'

" Completion and search stuff
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
Plug 'mhinz/vim-grepper'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

Plug 'Shougo/denite.nvim'
Plug 'Shougo/neco-vim'
Plug 'galooshi/vim-import-js'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'roxma/nvim-yarp'

" General Syntax stuff
Plug 'sheerun/vim-polyglot'

" Python stuff
Plug 'klen/python-mode', { 'for': 'python' }

" CSS/SCSS stuff
Plug 'othree/csscomplete.vim', { 'for': ['css', 'sass', 'scss'] }

" End Plug Packages
call plug#end()
