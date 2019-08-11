" Sed Embedding:
" ==============
" Adapted from awk embedding in :h sh-embed

if exists("b:current_syntax")
	unlet b:current_syntax
endif

syn include @sedScript syntax/sed.vim
syn region sedScriptCode matchgroup=sedCommand start=+[=\\]\@<!'+ skip=+\\'+ end=+'+ contains=@sedScript contained
syn region sedScriptEmbedded matchgroup=sedCommand start=+\<sed\>+ skip=+\\$+ end=+[=\\]\@<!'+me=e-1 contains=@shIdList,@shExprList2 nextgroup=sedScriptCode
syn cluster shCommandSubList add=sedScriptEmbedded
hi def link sedCommand Type
