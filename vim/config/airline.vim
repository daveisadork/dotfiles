" Airline Setup
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='base16_monokai_pro'
let g:airline#extensions#tabline#tab_nr_type=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#tmuxline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty=' '

" if you want to disable auto detect, comment out those two lines
"let g:airline#extensions#disable_rtp_load = 1
"let g:airline_extensions = ['branch', 'hunks', 'coc']

" let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
" let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

let g:tmuxline_preset='solarline'
" let g:tmuxline_theme='airline'

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

let g:tmuxline_theme = 'monokai_pro'
