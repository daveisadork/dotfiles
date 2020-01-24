" Basic setup
set encoding=utf-8
scriptencoding utf-8
set timeoutlen=500 ttimeoutlen=0
set nowrap

filetype on
filetype plugin on
filetype indent on
syntax on

let mapleader = ','  " Make leader useful on osx

" Syntax/linting setup
set statusline+=%#warningmsg#
set statusline+=%*

set shortmess+=c
set colorcolumn=81
set number
set ruler

" UI config
set background=dark

set guifont=Source\ Code\ Pro:h12
set guioptions=egmLt

" Turn off that stupid quote hiding in JSON
set conceallevel=0

set diffopt+=vertical

" Tabs and indention
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set backspace=indent,eol,start " make backspace work like most other programs
set list lcs=tab:⤚—
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set mouse=a

" <Tab> and <Shift-Tab> to indent/unindent selected text
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv  

" Performance stuff
" set synmaxcol=120 " Disable syntax highlighting past 120 chars 

set clipboard=unnamed  " This does pbcopy/pbpaste integration

set undofile  " persistent undo
set undodir=~/.vimundo

" Other random junk from http://items.sjbach.com/319/configuring-vim-right
set hidden  " switch buffers without having to save
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

set guicursor=
set completeopt-=preview

" Better display for messages
" set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" always show signcolumns
set signcolumn=yes

source ~/.vim/config/environment.vim
source ~/.vim/config/plugins.vim
source ~/.vim/config/pymode.vim
source ~/.vim/config/prettier.vim
source ~/.vim/config/fzf.vim
source ~/.vim/config/coc.vim
source ~/.vim/config/misc.vim
source ~/.vim/config/colors.vim
source ~/.vim/config/airline.vim
source ~/.vim/config/semshi.vim
source ~/.vim/config/prose.vim

" Auto-close the quickfix buffer if it's the only remaining buffer
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 79
    autocmd FileType python highlight Excess guifg=DarkRed ctermfg=DarkRed ctermbg=Black guibg=Black
    autocmd FileType python match Excess /\%89v.*/
    autocmd FileType python set colorcolumn=89
    autocmd FileType python,scss,css,html,eruby,yaml,javascript,json,php,typescript set nowrap
    autocmd FileType css,eruby,html,javascript,jinja.html,json,ruby,scss,typescript,vim,yaml,zsh set ai sw=2 sts=2 et
    " autocmd FileType python setlocal completeopt+=longest,menuone
    " autocmd FileType python setlocal completeopt=menuone,menu,longest,preview

    " rename tmux window
    " autocmd BufEnter,BufFilePost,BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
augroup END

augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css,scss.css,sass,less setlocal iskeyword+=-
  " au BufRead,BufNewFile *.scss set filetype=scss.css
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


