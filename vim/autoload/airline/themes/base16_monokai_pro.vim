"  " vim-airline template by chartoin (http://github.com/chartoin)
"  " Base 16 Monokai Pro Scheme 
"  let g:airline#themes#base16_monokai_pro#palette = {}
"  
"      "statusBar.border": "#19181a",
"      "titleBar.activeBackground": "#221f22",
"      "titleBar.activeForeground": "#939293",
"      "titleBar.inactiveBackground": "#221f22",
"      "titleBar.inactiveForeground": "#5b595c",
"      "titleBar.border": "#19181a",
"      "notificationCenter.border": "#403e41",
"      "notificationCenterHeader.foreground": "#939293",
"      "notificationCenterHeader.background": "#403e41",
"      "notificationToast.border": "#403e41",
"      "notifications.foreground": "#c1c0c0",
"      "notifications.background": "#403e41",
"      "notifications.border": "#403e41",
"      "notificationLink.foreground": "#ffd866",
"      "extensionButton.prominentForeground": "#fcfcfa",
"      "extensionButton.prominentBackground": "#403e41",
"      "extensionButton.prominentHoverBackground": "#5b595c",
"      "
"  "['#ff6188',
"  " '#ffd866',
"  " '#fc9867',
"  " '#a9dc76',
"  " '#78dce8',
"  " '#ab9df2',
"  " '#000000',
"  " '#19181a',
"  " '#221f22',
"  " '#2d2a2e',
"  " '#403e41',
"  " '#5b595c',
"  " '#727072',
"  " '#939293',
"  " '#c1c0c0',
"  " '#fcfcfa']
"  "[('#403e41', 51),
"  " ('#fcfcfa', 43),
"  " ('#2d2a2e', 37),
"  " ('#ff6188', 17),
"  " ('#5b595c', 17),
"  " ('#ffd866', 16),
"  " ('#221f22', 16),
"  " ('#939293', 15),
"  " ('#fc9867', 12),
"  " ('#727072', 11),
"  " ('#000000', 11),
"  " ('#19181a', 8),
"  " ('#c1c0c0', 8),
"  " ('#78dce8', 8),
"  " ('#a9dc76', 8),
"  " ('#ab9df2', 3)]
"  let s:gui00 = "#19181a"
"  let s:gui01 = "#2d2a2e"
"  let s:gui02 = "#403E41"
"  let s:gui03 = "#5b595c"
"  let s:gui04 = "#727072"
"  let s:gui05 = "#939293"
"  let s:gui06 = "#c1c0c0"
"  let s:gui07 = "#FCFCFA"
"  let s:gui08 = "#FF6188"
"  let s:gui09 = "#FC9867"
"  let s:gui0A = "#FFD866"
"  let s:gui0B = "#A9DC76"
"  let s:gui0C = "#78DCE8"
"  let s:gui0D = "#AB9DF2"
"  
"  let s:cterm00 = 0
"  let s:cterm01 = 59
"  let s:cterm02 = 59
"  let s:cterm03 = 95
"  let s:cterm04 = 144
"  let s:cterm05 = 15
"  let s:cterm06 = 15
"  let s:cterm07 = 15
"  let s:cterm08 = 197
"  let s:cterm09 = 208
"  let s:cterm0A = 216
"  let s:cterm0B = 3
"  let s:cterm0C = 158
"  let s:cterm0D = 81
"  let s:cterm0E = 141
"  let s:cterm0F = 167
"  
"  let s:N1   = [ s:gui01, s:gui0C, s:cterm01, s:cterm0C ]
"  let s:N2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
"  let s:N3   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
"  let g:airline#themes#base16_monokai_pro#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
"  
"  let s:I1   = [ s:gui01, s:gui0A, s:cterm01, s:cterm0A ]
"  let s:I2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
"  let s:I3   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
"  let g:airline#themes#base16_monokai_pro#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
"  
"  let s:R1   = [ s:gui01, s:gui08, s:cterm01, s:cterm08 ]
"  let s:R2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
"  let s:R3   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
"  let g:airline#themes#base16_monokai_pro#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
"  
"  let s:V1   = [ s:gui01, s:gui0D, s:cterm01, s:cterm0D ]
"  let s:V2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
"  let s:V3   = [ s:gui05, s:gui01, s:cterm09, s:cterm01 ]
"  let g:airline#themes#base16_monokai_pro#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
"  
"  let s:IA1   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
"  let s:IA2   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
"  let s:IA3   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
"  let g:airline#themes#base16_monokai_pro#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
"  
"  " Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
"  " variable so that related functionality is loaded iff the user is using
"  " ctrlp. Note that this is optional, and if you do not define ctrlp colors
"  " they will be chosen automatically from the existing palette.
"  if !get(g:, 'loaded_ctrlp', 0)
"    finish
"  endif
"  let g:airline#themes#base16_monokai_pro#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
"        \ [ s:gui07, s:gui02, s:cterm07, s:cterm02, '' ],
"        \ [ s:gui07, s:gui04, s:cterm07, s:cterm04, '' ],
"        \ [ s:gui05, s:gui01, s:cterm05, s:cterm01, 'bold' ])
"
"  "['#ff6188',
"  " '#ffd866',
"  " '#fc9867',
"  " '#a9dc76',
"  " '#78dce8',
"  " '#ab9df2',
"  " '#000000',
"  " '#19181a',
"  " '#',
"  " '#',
"  " '#',
"  " '#',
"  " '#',
"  " '#',
"  " '#c1c0c0',
"  " '#']
let g:airline#themes#base16_monokai_pro#palette = {}
let s:gui00 = "#221f22"
let s:gui01 = "#2d2a2e"
let s:gui02 = "#403e41"
let s:gui03 = "#5b595c"
let s:gui04 = "#727072"
let s:gui05 = "#939293"
let s:gui06 = "#c1c0c0"
let s:gui07 = "#fcfcfa"
let s:gui08 = "#ff6188"
let s:gui09 = "#fc9867"
let s:gui0A = "#ffd866"
let s:gui0B = "#a9dc76"
let s:gui0C = "#78dce8"
let s:gui0D = "#78dce8"
let s:gui0E = "#ab9df2"
let s:gui0F = "#cc6633"

let s:cterm00 = 0
let s:cterm01 = 59
let s:cterm02 = 59
let s:cterm03 = 95
let s:cterm04 = 144
let s:cterm05 = 15
let s:cterm06 = 15
let s:cterm07 = 15
let s:cterm08 = 197
let s:cterm09 = 208
let s:cterm0A = 216
let s:cterm0B = 3
let s:cterm0C = 158
let s:cterm0D = 81
let s:cterm0E = 141
let s:cterm0F = 167

let s:N1   = [ s:gui01, s:gui0B, s:cterm01, s:cterm0B ]
let s:N2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:N3   = [ s:gui05, s:gui00, s:cterm05, s:cterm01 ]
let g:airline#themes#base16_monokai_pro#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let s:I1   = [ s:gui01, s:gui0D, s:cterm01, s:cterm0D ]
let s:I2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:I3   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
let g:airline#themes#base16_monokai_pro#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

let s:R1   = [ s:gui01, s:gui08, s:cterm01, s:cterm08 ]
let s:R2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:R3   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
let g:airline#themes#base16_monokai_pro#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

let s:V1   = [ s:gui01, s:gui0E, s:cterm01, s:cterm0E ]
let s:V2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:V3   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
let g:airline#themes#base16_monokai_pro#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

let s:IA1   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
let s:IA2   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
let s:IA3   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
let g:airline#themes#base16_monokai_pro#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

" Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
" variable so that related functionality is loaded iff the user is using
" ctrlp. Note that this is optional, and if you do not define ctrlp colors
" they will be chosen automatically from the existing palette.
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#base16_monokai_pro#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ s:gui07, s:gui02, s:cterm07, s:cterm02, '' ],
      \ [ s:gui07, s:gui04, s:cterm07, s:cterm04, '' ],
      \ [ s:gui05, s:gui01, s:cterm05, s:cterm01, 'bold' ])
