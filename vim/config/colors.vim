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

let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 1

if has('nvim') && has('termguicolors') && $TRUE_COLOR
    set termguicolors
    let g:solarized_termtrans=1
    let g:solarized_degrade=0
else
    set t_Co=256
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
