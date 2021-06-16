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
" nnoremap <silent> <leader>s :Rg<CR> 
" nnoremap <silent> <leader>b :Buffers<CR> 
" "nnoremap <silent> <leader>p :Files<CR>
" nnoremap <silent> <leader>gC :BCommits<CR>
" nnoremap <silent> <leader>gc :Commits<CR>
" nnoremap <C-p> :GFiles<CR>

nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-g> <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>sf <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>sg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>sb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>sh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>sh <cmd>lua require('telescope.builtin').git_bcommits()<cr>
