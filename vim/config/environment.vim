" Environment detection/setup
if has('nvim')
    if has("unix")
        let s:uname = system("uname")
        let g:python3_host_prog='/usr/bin/python3'
        let g:python_host_prog='/usr/bin/python2'
        if s:uname == "Darwin\n"
            let g:python3_host_prog='/usr/local/bin/python3'
            let g:python_host_prog='/usr/local/bin/python2'
        endif
    endif
endif
