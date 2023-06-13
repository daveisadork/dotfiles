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

lua << EOF
local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/vendor/*", "--glob", "!**/node_modules/*"  },
		},
	},
})
EOF
