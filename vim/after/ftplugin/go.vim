" Jump between errors in quickfix list
map <silent> <C-n> :cnext<CR>
map <silent> <C-m> :cprevious<CR>
nnoremap <silent> <LocalLeader>a :cclose<CR>

" go run current file
nmap <silent> <LocalLeader>r <Plug>(go-run)

" go test current file
nmap <silent> <LocalLeader>t <Plug>(go-test)

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

nmap <silent><buffer> <LocalLeader>b :<C-u>call <SID>build_go_files()<CR>

" Toggle coverage
nmap <silent><buffer> <LocalLeader>c <Plug>(go-coverage-toggle)

" Normalize whitespace when joining multi-line constructs - doesn't do
" anything currently
let b:splitjoin_normalize_whitespace = 1

" Open alternate file (here, in vertical split, in split, in tab)
command! -bang -buffer A call go#alternate#Switch(<bang>0, 'edit')
command! -bang -buffer AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang -buffer AS call go#alternate#Switch(<bang>0, 'split')
command! -bang -buffer AT call go#alternate#Switch(<bang>0, 'tabe')

" Show information about identifier under cursor
nmap <buffer><silent> <LocalLeader>i <Plug>(go-info)

" Highlight other occurrences of identifier under cursor
nmap <buffer><silent> <LocalLeader>s :GoSameIdsToggle<CR>
