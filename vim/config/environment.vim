" Environment detection/setup
if has('nvim')
    if has("unix")
        let g:python3_host_prog=$SYS_PREFIX . '/bin/python3'
        let g:python_host_prog=$SYS_PREFIX . '/bin/python2'
    endif
endif
