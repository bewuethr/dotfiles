" bc Embedding:
" ==============
" Adapted from awk embedding in :h sh-embed

if exists("b:current_syntax")
  unlet b:current_syntax
endif

syn include @bcScript syntax/bc.vim
syn region bcScriptEmbedded matchgroup=bcCommand start=+\<bc\>.*<<-\?\z([A-Z]\+\)+ skip=+\\$+ end=+^\s*\z1+ contains=@bcScript
syn cluster shCommandSubList add=bcScriptEmbedded
hi def link bcCommand Type
