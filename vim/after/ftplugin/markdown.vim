noremap <expr> <buffer> k v:count == 0 ? 'gk' : 'k'
noremap <expr> <buffer> j v:count == 0 ? 'gj' : 'j'
noremap <expr> <buffer> 0 'g0'
noremap <expr> <buffer> $ 'g$'
setlocal linebreak
setlocal colorcolumn=0
setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
setlocal spell spelllang=en_ca spellcapcheck=

" Don't complain about 1. 2. 3. instead of 1. 1. 1. for ordered lists
let b:ale_markdown_mdl_options = '--style ordered'
