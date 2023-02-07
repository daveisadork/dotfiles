""  Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>u <Plug>(coc-references)
nmap <silent> <leader>l <Plug>(coc-action-code-lens-action)
autocmd CursorHold * silent call CocActionAsync('highlight')


" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
nmap <silent> <leader>f <Plug>(coc-format)
nnoremap <silent> <leader>is :CocCommand python.sortImports<CR>
vmap <leader>f <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

nnoremap <silent> <leader>p :CocCommand prettier.formatFile<CR>

nnoremap <silent> <leader>gb :Gblame<CR> 
nnoremap <silent> <leader>gs :Gstatus<CR> 
nnoremap <silent> <leader>gf :Gfetch<CR> 
nnoremap <silent> <leader>gl :0Glog<CR> 
nnoremap <silent> <leader>gr :Gbrowse<CR> 

nnoremap <silent> <leader>hn :CocCommand post.new<CR>
nnoremap <silent> <leader>hd :CocCommand post.do<CR>
nnoremap <silent> <leader>hn :CocList post<CR>

nnoremap <silent> <leader>m :CocList marketplace<CR>
