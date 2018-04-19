noremap <expr> <buffer> k v:count == 0 ? 'gk' : 'k'
noremap <expr> <buffer> j v:count == 0 ? 'gj' : 'j'
noremap <expr> <buffer> 0 'g0'
noremap <expr> <buffer> $ 'g$'
setlocal linebreak
setlocal colorcolumn=0
setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
