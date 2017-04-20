set nocompatible
set encoding=utf-8
set timeoutlen=500 ttimeoutlen=0
call plug#begin('~/.config/nvim/plugged')
if has("termguicolors")
    set termguicolors
    let g:python_host_prog = '/usr/local/bin/python'
    Plug 'frankier/neovim-colors-solarized-truecolor-only'
else
    set t_Co=256
    let g:python_host_prog = '/usr/bin/python'
    Plug 'altercation/vim-colors-solarized'
endif

Plug 'scrooloose/syntastic'

" Visual stuff
Plug 'bling/vim-airline'
" Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
Plug 'lilydjwg/colorizer'

" Utility stuff
Plug 'editorconfig/editorconfig-vim'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-git'
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'kien/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
" Plug 'tpope/vim-repeat'
" Plug 'airblade/vim-gitgutter'

" Completion stuff
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe'

" Python stuff
Plug 'klen/python-mode', { 'for': 'python' }
Plug 'davidhalter/jedi-vim'
" Plug 'jmcantrell/vim-virtualenv'

" JavaScript stuff
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'Shutnik/jshint2.vim', { 'for': 'javascript' }
Plug 'elzr/vim-json'
Plug 'mustache/vim-mustache-handlebars'

" CSS/SCSS stuff
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'

" Other languages
" Plug 'jcf/vim-latex'
" Plug 'lambdatoast/elm.vim'
Plug 'stephpy/vim-yaml'
" Plug '4Evergreen4/vim-hardy'
" Plug 'derekwyatt/vim-scala'

" Other random shit
Plug 'edkolev/promptline.vim'
" Plug 'edkolev/tmuxline.vim'

" End Vundle Packages
call plug#end()

" Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Airline Setup
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='solarline'
let g:airline#extensions#tabline#tab_nr_type=1
let g:airline#extensions#tabline#buffer_nr_show=1

" NerdTree Setup
map <C-o> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0

" Linting
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 0
"let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Enable rainbow parentheses
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" Don't autofold code
let g:pymode_folding = 0

" let jshint2_save = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['python']

filetype on
filetype plugin on
filetype indent on

" Auto-close the quickfix buffer if it's the only remaining buffer
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Completion junk
let g:ycm_python_binary_path = 'python'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:jedi#show_call_signatures_delay = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0

augroup vimrc_autocmds
    autocmd!

    " highlight characters past column 80
    autocmd FileType python highlight Excess ctermbg=Black guibg=Black
    autocmd FileType python match Excess /\%80v.*/
    autocmd FileType python set nowrap
    autocmd FileType css,html,ruby,eruby,yaml set ai sw=2 sts=2 et
    autocmd FileType python setlocal completeopt+=longest,menuone

    " These are the tweaks I apply to YCM's config, you don't need them but
    " they might help. YCM gives you popups and splits by default that some
    " people might not like, so these should tidy it up a bit for you.
    " autocmd Filetype javascript let g:ycm_add_preview_to_completeopt=0
    autocmd Filetype javascript let g:ycm_confirm_extra_conf=0
    " autocmd Filetype javascript set completeopt-=preview
    autocmd Filetype javascript let g:used_javascript_libs = 'angularjs,angularui,angularuirouter,jquery'

    " rename tmux window
    autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
augroup END

" <Tab> and <Shift-Tab> to indent/unindent selected text
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command -nargs=0 -bar Update if &modified 
                           \|   if empty(bufname('%'))
                           \|       browse confirm write
                           \|   else
                           \|       confirm write
                           \|   endif
                           \|endif

" UI config
syntax enable
set background=dark

set guifont=Source\ Code\ Pro:h12
set go=egmLt

" Set up display stuff
" set cursorline
set colorcolumn=80
set number
set ruler

" Turn off that stupid quote hiding in JSON
set conceallevel=0
let g:vim_json_syntax_conceal = 0

set diffopt+=vertical

" Tabs and indention
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set backspace=indent,eol,start
let g:indentLine_enabled = 0
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
set list lcs=tab:⤚—
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set mouse=a
let g:SuperTabDefaultCompletionType = "<c-n>"

" Performance stuff
set synmaxcol=120
set ttyfast " u got a fast terminal
" set ttyscroll=9
" set lazyredraw " to avoid scrolling problems

" This does pbcopy/pbpaste integration
set clipboard=unnamed

" persistent undo
set undofile
set undodir=~/.vimundo

" Other random junk from http://items.sjbach.com/319/configuring-vim-right
set hidden  " switch buffers without having to save
let mapleader = ","  " Make leader useful on osx
set history=1000  " command history"
set wildmenu
set wildmode=list:longest
set ignorecase 
set smartcase
set scrolloff=3
runtime macros/matchit.vim

" Highlight search terms...
" set hlsearch
set incsearch " ...dynamically as they are typed."
let g:solarized_termtrans=1
let g:solarized_degrade=0

" Try loading the solarized them, call the vundle install routine if it fails
try
    colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
    PlugInstall
    colorscheme solarized
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:promptline_preset = {
    \'a'    : [ promptline#slices#python_virtualenv() ],
    \'b'    : [ '$USER' ],
    \'c'    : [ '%~' ],
    \'x'    : [ promptline#slices#vcs_branch() ],
    \'y'    : [ promptline#slices#host({ 'only_if_ssh': 1  }) ],
    \'z'    : [],
    \'warn' : [ promptline#slices#last_exit_code() ],
    \'options': {
        \'left_sections' : [ 'y', 'b', 'a', 'x', 'c', 'z', 'warn' ],
        \'right_sections': []}}

let g:tmuxline_preset='solarline'
let g:tmuxline_theme='airline'
