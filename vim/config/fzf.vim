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

" fzf setup
nnoremap <silent> <leader>s :Rg<CR> 
nnoremap <silent> <leader>w :Buffers<CR> 
"nnoremap <silent> <leader>p :Files<CR>
nnoremap <silent> <leader>b :BCommits<CR>
nnoremap <silent> <leader>c :Commits<CR>
nnoremap <C-p> :GFiles<CR>
