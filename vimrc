execute pathogen#infect()

" Indentation
set shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab

" Colours
let g:solarized_termtrans = 1
let g:solarized_old_cursor_style = 1
let g:solarized_term_italics = 1
set termguicolors
set background=dark
colorscheme solarized8

" Highlight previous search matches
set hlsearch

" Ignore case in searches, unless there is an uppercase character. Tags don't ignore case.
set ignorecase smartcase tagcase=match

" Highlight current line
set cursorline

" Activate mouse
set mouse=a

" Save file when following tag
set autowrite

" Read modeline if present
set autoread modeline

" Shell syntax highlighting defaults to Bash
let g:is_bash = 1

" Enable syntax highlighting for Bash specific readline commands
let g:readline_has_bash = 1

" netrw settings
" Hide directory banner
let g:netrw_banner = 0

" Use tree style listing
let g:netrw_liststyle = 3

" Open splits in previous window
let g:netrw_browse_split = 4

" Vertical split to the right
let g:netrw_altv = 1

" Set netrw window width in percent of total window width
let g:netrw_winsize = 20

" Hide swap files
let g:netrw_list_hide= '.*\.swp$'

" Plugins

" Vimwiki settings
let g:vimwiki_list = [{
\	'path': '~/vimwiki',
\	'syntax': 'markdown',
\	'ext': '.wiki',
\	'list_margin': 0,
\	'auto_toc': 0,
\	'auto_tags': 1,
\	'auto_export': 0,
\	'auto_diary_index': 1,
\	'custom_wiki2html': '~/bin/vimwiki2html',
\}]

let g:vimwiki_global_ext = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_html_header_numbering = 2
let g:vimwiki_dir_link = 'index'

" Calendar.vim settings
let g:calendar_monday = 1

" Lion.vim settings
let g:lion_squeeze_spaces = 1

" Ale settings
" Bind F8 to fixing problems
nmap <F8> <Plug>(ale_fix)

" Format for message when cursor near warning/error
let g:ale_echo_msg_format = '%severity%% (code)%: %s'

" Set non-default linters
let g:ale_linters = {'json': ['jq'], 'perl': ['perl', 'perlcritic']}

" Set non-default fixers
let g:ale_fixers = {'json': ['jq'], 'sh': ['shfmt']}

" Keep gutter around even if there are no errors
let g:ale_sign_column_always = 1

" Pandoc settings
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#syntax#codeblocks#embeds#langs = ["bash=sh", "sh"]

" vim-go settings
" Use goimports instead of gofmt
let g:go_fmt_command = "goimports"

" Syntax highlighting
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

" Add git branch to statusline
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Local settings
if filereadable(expand("~/.vimrc_local"))
	source ~/.vimrc_local
endif
