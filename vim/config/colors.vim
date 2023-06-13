" Enabled GUI/TrueColor
set termguicolors
let g:solarized_extra_hi_groups = 1

" Try loading the solarized them, call the vundle install routine if it fails
try
  colorscheme solarized8
catch /^Vim\%((\a\+)\)\=:E185/
  PlugInstall
  colorscheme solarized8
endtry

" let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_fields = 1
let g:go_highlight_types = 1
" let g:go_highlight_variable_declarations = 1
" let g:go_highlight_variable_assignments = 1

" Enable rainbow parentheses
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

let g:rainbow_conf = {
\  'guifgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\  'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\  'operators': '_,_',
\  'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\  'separately': {
\    '*': {},
\    'tex': {
\      'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\    },
\    'lisp': {
\      'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\    },
\    'vim': {
\      'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\    },
\    'html': 0,
\    'css': 0,
\  }
\}

