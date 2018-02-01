" Basic setup
set nocompatible
set encoding=utf-8
set timeoutlen=500 ttimeoutlen=0
set nowrap
filetype on
filetype plugin on
filetype indent on

" Environment detection/setup
if has('nvim')
    if has("unix")
        let s:uname = system("uname")
        let g:python3_host_prog='/usr/bin/python3'
        let g:python_host_prog='/usr/bin/python2'
        if s:uname == "Darwin\n"
            let g:python3_host_prog='/usr/local/bin/python3'
            let g:python_host_prog='/usr/local/bin/python2'
        endif
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use different plugin directories for neovim and vim
if has('nvim')
    call plug#begin('~/.vim/plugged-nvim')
else
    call plug#begin('~/.vim/plugged')
endif

" Use neovim specific solarized
if has('nvim')
    Plug 'iCyMind/NeoSolarized'
else
    Plug 'altercation/vim-colors-solarized'
endif

" Test running
Plug 'janko-m/vim-test'

" Airline/tmux/zsh
Plug 'bling/vim-airline'
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'

" Code visualization stuff
Plug 'lilydjwg/colorizer'
Plug 'luochen1990/rainbow'

" Utility stuff
" Plug 'airblade/vim-gitgutter'
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
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
" Plug 'mileszs/ack.vim'
" Plug 'numkil/ag.nvim'
Plug 'mhinz/vim-grepper'

if has('nvim')
    " Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
    Plug 'Shougo/neco-syntax'
    Plug 'Shougo/neco-vim'
    " Plug 'daveisadork/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
    Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'make release'}
    Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
    Plug 'roxma/ncm-flow'
    Plug 'roxma/ncm-github'
    Plug 'roxma/ncm-rct-complete'
    Plug 'roxma/nvim-completion-manager'
    Plug 'roxma/python-support.nvim'
else
    Plug 'Valloric/YouCompleteMe'
endif

" General Syntax stuff
Plug 'w0rp/ale'

" Python stuff
Plug 'klen/python-mode', { 'for': 'python' }
Plug 'Glench/Vim-Jinja2-Syntax'

" JavaScript stuff
" Plug 'Shutnik/jshint2.vim', { 'for': 'javascript' }
" Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
" Plug 'mustache/vim-mustache-handlebars'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim'

" CSS/SCSS stuff
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }

" Other languages
Plug 'jcf/vim-latex', { 'for': 'tex' }
Plug 'lambdatoast/elm.vim'
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'JamshedVesuna/vim-markdown-preview', { 'for': 'markdown' }

" End Plug Packages
call plug#end()

" LanguageClient-neovim setup
let g:LanguageClient_serverCommands = {
    \ 'python': ['~/.dotfiles/bin/pyls.sh'],
    \ 'javascript': ['node', '~/.dotfiles/node/node_modules/.bin/javascript-typescript-stdio'],
    \ 'typescript': ['node', '~/.dotfiles/node/node_modules/.bin/javascript-typescript-stdio'],
    \ 'css': ['node', '~/.dotfiles/node/node_modules/.bin/css-language-server', '--stdio'],
    \ 'dockerfile': ['node', '~/.dotfiles/node/node_modules/.bin/docker-langserver', '--stdio'],
    \ 'yaml': ['node', '~/.dotfiles/node/node_modules/.bin/docker-langserver', '--stdio'],
    \ 'c': ['cquery', '--language-server'],
    \ 'cpp': ['cquery', '--language-server'],
    \ 'objc': ['cquery', '--language-server'],
    \ }

let g:LanguageClient_rootMarkers = {
    \ 'python': ['setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'main.py', 'tox.ini'],
    \ }

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = $HOME . '/.config/nvim/settings.json'

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

let g:LanguageClient_diagnosticsEnable = 0
" Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Airline Setup
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='solarline'
let g:airline#extensions#tabline#tab_nr_type=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#ale#enabled = 1

" python-mode setup
" Just disable everything but the nicer syntax and virtualenv
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_lint = 0
let g:pymode_lint_write = 0
let g:pymode_breakpoint = 0

" Support virtualenv
let g:pymode_virtualenv = 1

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Enable rainbow parentheses
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" Don't autofold code
let g:pymode_folding = 0


" Syntax/linting setup
set statusline+=%#warningmsg#
set statusline+=%*

" Ale setup
let g:ale_linters = {'javascript': ['eslint'], 'jinja.html': [], 'html': []}
let g:ale_python_flake8_executable = $HOME . '/.dotfiles/bin/flake8.sh'
let g:ale_python_flake8_use_global = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_open_list = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" s:compute_working_directory() {{{2
function! s:compute_working_directory() abort
    let repopath = finddir('.git', '.;')
    if empty(repopath)
        let repopath = findfile('requirements.txt', '.;')
    endif
    if !empty(repopath)
        let repopath = fnamemodify(repopath, ':h')
        return fnameescape(repopath)
    endif
    let cwd = getcwd()
    let bufdir = expand('%:p:h')
    if stridx(bufdir, cwd) != 0
      return fnameescape(bufdir)
    endif
    let bufdir = expand('%:p:h')
    return fnameescape(bufdir)
endfunction


let g:search_root = s:compute_working_directory()


" fzf setup
" nnoremap <C-o> :Files<CR>
nnoremap <C-p> :GFiles<CR>
" nnoremap <C-i> :GFiles?<CR>
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Ag/Ack setup
let g:ag_working_path_mode="r"
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" nnoremap <silent> <C-p> :call fzf#vim#files(g:search_root)<CR>
let g:ag_highlight = 1
let g:ag_autoclose = 1

let g:ack_autoclose = 1
let g:ack_highlight = 1
let g:ack_use_cword_for_empty_search = 1
" nnoremap <C-g> :Ack<CR>
let g:grepper = {}
let g:grepper.quickfix = 0
let g:grepper.dir = 'repo,filecwd'
nnoremap <silent> <C-g> :Grepper -cword -noprompt<cr>

" Completion setup
" set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
let g:cm_sources_enable = 1
let g:cm_sources_override = {
    \ 'LanguageClient_python': {'enable':0}
    \ }

" Completion junk
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures_delay = 999

" Auto-close the quickfix buffer if it's the only remaining buffer
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

augroup vimrc_autocmds
    autocmd!
    autocmd FileType php LanguageClientStart
    " highlight characters past column 79
    " autocmd FileType python highlight Excess guifg=DarkRed ctermfg=DarkRed ctermbg=Black guibg=Black
    " autocmd FileType python match Excess /\%80v.*/
    " autocmd FileType python set colorcolumn=80
    autocmd FileType python,css,html,eruby,yaml,javascript,json,php set nowrap
    autocmd FileType css,html,jinja.html,ruby,eruby,yaml,javascript,json set ai sw=2 sts=2 et
    " autocmd FileType python setlocal completeopt+=longest,menuone
    " autocmd FileType python setlocal completeopt=menuone,menu,longest,preview

    " rename tmux window
    autocmd BufEnter,BufFilePost,BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
augroup END

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

" <Tab> and <Shift-Tab> to indent/unindent selected text
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

" Performance stuff
set synmaxcol=120 " Disable syntax highlighting past 120 chars 
if $REMOTE_SESSION
    set lazyredraw " to avoid scrolling problems
else
    set cursorline
    set ttyfast " u got a fast terminal
    if !has('nvim')
        set ttyscroll=200
    endif
endif

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

" Try loading the solarized them, call the vundle install routine if it fails
try
    if has('nvim')
        colorscheme NeoSolarized
    else
        colorscheme solarized
    endif
catch /^Vim\%((\a\+)\)\=:E185/
    PlugInstall
    if has('nvim')
        colorscheme NeoSolarized
    else
        colorscheme solarized
    endif
endtry

" vim-test setup
let test#strategy = "neovim"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>f :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Safari'

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
" let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys=0
let g:tern_request_timeout = 3
let g:flow#enable = 1
let g:flow#autoclose = 1

"Add extra filetypes
let g:tern#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue'
                \ ]

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

if has('nvim') && has('termguicolors') && $TRUE_COLOR
    set termguicolors
    let g:solarized_termtrans=1
    let g:solarized_degrade=0
else
    set t_Co=256
endif
if has('nvim')
    set guicursor=
    set completeopt-=preview
    nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    nnoremap <leader>d :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
    nnoremap <leader>r :call LanguageClient_textDocument_rename()<CR>
    nnoremap <leader>u :call LanguageClient_textDocument_references()<CR>
    let g:python_support_python3_requirements = get(g:, 'python_support_python3_requirements', []) + [
        \ 'psutil',
        \ 'python-language-server',
        \ 'flake8'
    \ ]
    let g:python_support_python2_requirements = get(g:, 'python_support_python2_requirements', []) + [
        \ 'psutil',
        \ 'python-language-server',
        \ 'flake8'
    \ ]
else
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#goto_command = ""
    let g:jedi#goto_assignments_command = ""
    let g:jedi#goto_definitions_command = ""
    let g:jedi#documentation_command = "K"
    let g:jedi#usages_command = ""
    let g:jedi#completions_command = ""
    let g:jedi#rename_command = "<leader>r"

    " let g:ycm_python_binary_path = 'python'
    let g:ycm_add_preview_to_completeopt = 1
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_complete_in_strings = 0
    nnoremap <leader>d :YcmCompleter GoTo<CR>
    nnoremap <leader>n :YcmCompleter GoToReferences<CR>
endif

let g:rainbow_conf =
\ {
    \ 'guifgs': [
         \ 'royalblue3',
         \ 'darkorange3',
         \ 'seagreen3',
         \ 'firebrick',
    \ ],
    \ 'ctermfgs': [
         \ 'lightblue',
         \ 'lightyellow',
         \ 'lightcyan',
         \ 'lightmagenta',
    \ ],
    \ 'operators': '_,_',
    \ 'parentheses': [
         \ 'start=/(/ end=/)/ fold',
         \ 'start=/\[/ end=/\]/ fold',
         \ 'start=/{/ end=/}/ fold',
    \ ],
    \ 'separately': {
        \ '*': {},
        \ 'tex': {
             \ 'parentheses': [
                 \ 'start=/(/ end=/)/',
                 \ 'start=/\[/ end=/\]/',
             \ ],
        \ },
        \ 'lisp': {
             \ 'guifgs': [
                 \ 'royalblue3',
                 \ 'darkorange3',
                 \ 'seagreen3',
                 \ 'firebrick',
                 \ 'darkorchid3',
             \ ],
         \ },
        \ 'vim': {
             \ 'parentheses': [
                 \ 'start=/(/ end=/)/',
                 \ 'start=/\[/ end=/\]/',
                 \ 'start=/{/ end=/}/ fold',
                 \ 'start=/(/ end=/)/ containedin=vimFuncBody',
                 \ 'start=/\[/ end=/\]/ containedin=vimFuncBody',
                 \ 'start=/{/ end=/}/ fold containedin=vimFuncBody',
             \ ],
         \ },
        \ 'html': 0,
        \ 'css': 0,
    \ }
\ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:promptline_preset = {
    \ 'a'    : [ promptline#slices#python_virtualenv() ],
    \ 'b'    : [ '$USER' ],
    \ 'c'    : [ '%~' ],
    \ 'x'    : [ promptline#slices#vcs_branch() ],
    \ 'y'    : [ promptline#slices#host({ 'only_if_ssh': 1  }) ],
    \ 'z'    : [],
    \ 'warn' : [ promptline#slices#last_exit_code() ],
    \ 'options': {
         \ 'left_sections' : [ 'y', 'b', 'a', 'x', 'c', 'z', 'warn' ],
         \ 'right_sections': []}}

let g:tmuxline_preset='solarline'
let g:tmuxline_theme='airline'
