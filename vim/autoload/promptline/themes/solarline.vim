"fun! promptline#themes#solarline#get()
"  let s:background  = get(g:, 'airline_solarline_bg', &background)
"  let s:ansi_colors = get(g:, 'solarline_termcolors', 16) != 256 && &t_Co >= 16 ? 1 : 0
"  let s:tty         = &t_Co == 8
"  let s:ansi_colors = 1
"  let s:tty         = 0
"  let s:base03  = {'t': s:ansi_colors ?   8 : (s:tty ? '0' : 234), 'g': '#002b36'}
"  let s:base02  = {'t': s:ansi_colors ? '0' : (s:tty ? '0' : 235), 'g': '#073642'}
"  let s:base01  = {'t': s:ansi_colors ?  19 : (s:tty ? '0' : 240), 'g': '#586e75'}
"  let s:base00  = {'t': s:ansi_colors ?  11 : (s:tty ? '7' : 241), 'g': '#657b83'}
"  let s:base0   = {'t': s:ansi_colors ?  12 : (s:tty ? '7' : 244), 'g': '#839496'}
"  let s:base1   = {'t': s:ansi_colors ?  14 : (s:tty ? '7' : 245), 'g': '#93a1a1'}
"  let s:base2   = {'t': s:ansi_colors ?  21 : (s:tty ? '7' : 254), 'g': '#eee8d5'}
"  let s:base3   = {'t': s:ansi_colors ?  15 : (s:tty ? '7' : 230), 'g': '#fdf6e3'}
"  let s:yellow  = {'t': s:ansi_colors ?   3 : (s:tty ? '3' : 136), 'g': '#b58900'}
"  let s:orange  = {'t': s:ansi_colors ?   9 : (s:tty ? '1' : 166), 'g': '#cb4b16'}
"  let s:red     = {'t': s:ansi_colors ?   1 : (s:tty ? '1' : 160), 'g': '#dc322f'}
"  let s:magenta = {'t': s:ansi_colors ?   5 : (s:tty ? '5' : 125), 'g': '#d33682'}
"  let s:violet  = {'t': s:ansi_colors ?  13 : (s:tty ? '5' : 61 ), 'g': '#6c71c4'}
"  let s:blue    = {'t': s:ansi_colors ?   4 : (s:tty ? '4' : 33 ), 'g': '#268bd2'}
"  let s:cyan    = {'t': s:ansi_colors ?   6 : (s:tty ? '6' : 37 ), 'g': '#2aa198'}
"  let s:green   = {'t': s:ansi_colors ?   2 : (s:tty ? '2' : 64 ), 'g': '#859900'}
"  return {
"        \'a'      : [s:base2.t, s:green.t],
"        \'b'      : [s:base2.t, s:blue.t],
"        \'c'      : [s:base2.t, s:base01.t],
"        \'x'      : [s:base2.t, s:cyan.t],
"        \'y'      : [s:base2.t, s:violet.t],
"        \'z'      : [s:base2.t, 236],
"        \'warn'   : [s:base2.t, s:red.t]}
"endfun
