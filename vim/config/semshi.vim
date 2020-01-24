let g:semshi#no_default_builtin_highlight = 'false'
" let g:semshi#simplify_markup = 'false'
" let g:semshi#always_update_all_highlights = 'true'
" function MyCustomHighlights()
"   hi semshiLocal           ctermfg=209 guifg=#ff875f
"   hi semshiGlobal          
"   hi semshiImported        gui=bold
"   hi semshiParameter       cterm=italic gui=italic
"   hi semshiParameterUnused gui=underline
"   hi semshiFree            gui=bold
"   "hi semshiBuiltin         guifg=#b58900
"   "hi semshiAttribute       guifg=#b58900
"   hi semshiSelf            guifg=#cb4b16
"   hi semshiUnresolved      guifg=#dc322f gui=underline
"   hi semshiSelected        guibg=#fdf6e3
" 
   hi semshiErrorSign       guifg=#fdf6e3 guibg=#dc322f
   hi semshiErrorChar       guifg=#fdf6e3 guibg=#dc322f
 sign define semshiError text=E> texthl=semshiErrorSign
" endfunction
"
"
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" hi jsFuncArgs ctermfg=209 ctermbg=NONE cterm=NONE guifg=#6c71c4 guibg=NONE gui=italic
" hi jsObjectKey ctermfg=209 ctermbg=NONE cterm=NONE guifg=#6c71c4 guibg=NONE gui=italic
hi jsObjectKey guifg=NONE gui=NONE
" hi def link jsDestructuringBlock jsUndefined
hi def link jsDestructuringBraces jsNoise
hi def link jsFuncArgs Directory
hi def link jsTemplateBraces jsNoise
hi def link jsSwitchColon jsNoise
hi def link jsSwitchBraces jsNoise
hi def link jsxTagName Tag
hi def link jsxComponentName Tag
hi def link jsxEscapeJsBraces Directory
"hi def link jsTemplateExpression jsTemplateBraces
hi def link jsStringQuotes jsNoise
hi def link jsxStringQuotes jsNoise
hi def link jsTemplateStringQuotes Keyword
hi jsThis ctermfg=246 ctermbg=NONE cterm=NONE guifg=#939293 guibg=NONE gui=italic
hi def link jsSuper jsThis
hi def link jsClassConstructor Type


function MyCustomHighlights()
  hi def link semshiLocal           Normal
  hi def link semshiGlobal          jsGlobalObjects
  " hi def link semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
  hi def link semshiParameter       jsFuncArgs
  hi def link semshiParameterUnused semshiParameter
  hi def link semshiFree            Normal
  hi def link semshiBuiltin         PythonBuiltin
  hi def link semshiAttribute       jsFuncCall
  hi def link semshiSelf            jsThis
  " hi def link semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
  " hi def link semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

  " hi def link semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
  " hi def link semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
endfunction
autocmd FileType python call MyCustomHighlights()
