" python-mode setup
" Just disable everything but the nicer syntax and virtualenv
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_lint = 0
let g:pymode_lint_write = 0
let g:pymode_breakpoint = 0
let g:pymode_run = 0

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

" Completion junk
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures_delay = 999
