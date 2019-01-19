" Airline Setup
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='solarline'
let g:airline#extensions#tabline#tab_nr_type=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#ale#enabled = 1

" if you want to disable auto detect, comment out those two lines
"let g:airline#extensions#disable_rtp_load = 1
"let g:airline_extensions = ['branch', 'hunks', 'coc']

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

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
