setlocal colorcolumn=0
noremap <expr> <buffer> k v:count == 0 ? 'gk' : 'k'
noremap <expr> <buffer> j v:count == 0 ? 'gj' : 'j'
noremap <buffer> 0 g0
noremap <buffer> $ g$
setlocal sbr=>\ 
setlocal wrap linebreak breakindent breakindentopt=shift:2,sbr
setlocal spell spelllang=en_ca spellcapcheck=
setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" Path to mdl style file
let b:ale_linters = ['mdl']
let b:ale_markdown_mdl_options = '--style ~/.config/mdl/vimwiki.rb'
