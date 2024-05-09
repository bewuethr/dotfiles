autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy

let current_file_path = expand('%:p:h')
let file_to_source = current_file_path . "/groovy_local.vim"
if filereadable(file_to_source)
	execute 'source' file_to_source
endif
