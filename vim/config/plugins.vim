"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Color schemes
Plug 'lifepillar/vim-solarized8'
Plug 'iCyMind/NeoSolarized'
Plug 'phanviet/vim-monokai-pro'
Plug 'crusoexia/vim-monokai'
Plug 'patstockwell/vim-monokai-tasty'

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
" Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'editorconfig/editorconfig-vim'
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
" Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
" Plug 'iamcco/sran.nvim', { 'do': { -> sran#util#install() } }
" Plug 'iamcco/git-p.nvim'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'metakirby5/codi.vim'

" Completion and search stuff
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
Plug 'mhinz/vim-grepper'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

Plug 'Shougo/denite.nvim'
" Plug 'Shougo/neco-vim'
Plug 'galooshi/vim-import-js'
" Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'roxma/nvim-yarp'

" General Syntax stuff
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Python stuff
Plug 'klen/python-mode'
Plug 'ambv/black'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" CSS/SCSS stuff
Plug 'hail2u/vim-css3-syntax'
Plug 'JulesWang/css.vim'
" Plug 'cakebaker/scss-syntax.vim'

" Writing
Plug 'reedes/vim-pencil' " Super-powered writing things
Plug 'tpope/vim-abolish' " Fancy abbreviation replacements
Plug 'junegunn/limelight.vim' " Highlights only active paragraph
Plug 'junegunn/goyo.vim' " Full screen writing mode
Plug 'reedes/vim-lexical' " Better spellcheck mappings
Plug 'reedes/vim-litecorrect' " Better autocorrections
Plug 'kana/vim-textobj-user'
Plug 'reedes/vim-textobj-sentence' " Treat sentences as text objects
Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-wordy' " Weasel words and passive voice
Plug 'ron89/thesaurus_query.vim'

" End Plug Packages
call plug#end()
