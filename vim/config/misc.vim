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

function! Prose() abort
  set wrap
  set linebreak
endfunction

nmap <silent> <leader>p :Prose<CR>

let g:search_root = s:compute_working_directory()

" GitGutter
" set updatetime=100
let g:gitgutter_override_sign_column_highlight = 0

let g:SuperTabDefaultCompletionType = "<c-n>"

let g:grepper = {}
let g:grepper.quickfix = 0
let g:grepper.dir = 'repo,filecwd'
let g:grepper.tools = ['rg', 'git', 'ag', 'grep']
nnoremap <silent> <C-g> :Grepper -cword -noprompt<cr>
" nnoremap <silent> <C-g> :Rg -cword -noprompt<cr>

let g:vim_json_syntax_conceal = 0
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

if $REMOTE_SESSION
    set lazyredraw " to avoid scrolling problems
else
    set cursorline
    set ttyfast " u got a fast terminal
    if !has('nvim')
        set ttyscroll=200
    endif
endif

" vim-test setup
let test#strategy = "neovim"
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Safari'
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=2

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
let g:polyglot_disabled = ['python', 'scss']

nnoremap <silent> <leader> :WhichKey ','<CR>

nmap <silent> <leader>if :ImportJSFix<CR>
nmap <silent> <leader>iw :ImportJSWord<CR>
nmap <silent> <leader>ig :ImportJSGoto<CR>

nmap <silent> <leader>B :Black<CR>
