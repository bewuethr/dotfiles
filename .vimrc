execute pathogen#infect()

" Indentation
set shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab

" Colours
set termguicolors
colorscheme flattened_dark

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

" Use patience diff algorithm
set diffopt+=algorithm:patience

" Plugins

" Vimwiki settings
let g:vimwiki_list = [{
\	'auto_diary_index': 1,
\	'auto_export': 0,
\	'auto_tags': 1,
\	'auto_toc': 1,
\	'bullet_types': ['-'],
\	'custom_wiki2html': '~/.local/bin/vimwiki2html',
\	'diary_caption_level': 1,
\	'ext': '.md',
\	'links_space_char': '_',
\	'list_margin': 0,
\	'path': '~/vimwiki',
\	'syntax': 'markdown'
\}]

let g:vimwiki_global_ext = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_html_header_numbering = 2
let g:vimwiki_dir_link = 'index'
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_toc_header_level = 2

" Calendar.vim settings
let g:calendar_monday = 1

" Lion.vim settings
let g:lion_squeeze_spaces = 1

" Ale settings
" Bind F8 to fixing problems
nmap <F8> <Plug>(ale_fix)

" Format for message when cursor near warning/error
let g:ale_echo_msg_format = '%severity%% (code)%: %s'

" Markers for gutter
let g:ale_sign_error = '😱'
let g:ale_sign_warning = '😳'
let g:ale_sign_info = '🤔'
let g:ale_sign_style_error = '🙄'
let g:ale_sign_style_warning = '🧐'

" Keep gutter around even if there are no errors
let g:ale_sign_column_always = 1

" Don't highlight gutter signs
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear ALEInfoSign
highlight clear ALEStyleErrorSign
highlight clear ALEStyleWarningSign

" Pandoc settings
let g:pandoc#filetypes#pandoc_markdown = 1
let g:pandoc#modules#enabled = []
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#syntax#codeblocks#embeds#langs = [
\	"ada",
\	"awk",
\	"bash=sh",
\	"c",
\	"clojure",
\	"cpp",
\	"css",
\	"dot",
\	"eiffel",
\	"go",
\	"html",
\	"java",
\	"javascript",
\	"json",
\	"latex=tex",
\	"lua",
\	"makefile=make",
\	"markdown",
\	"pascal",
\	"perl",
\	"python",
\	"roff=nroff",
\	"sed",
\	"sh",
\	"sql",
\	"sqlpostgresql=sql",
\	"xml",
\	"yaml"
\]
let g:pandoc#formatting#mode = "h"

" vim-go settings
" Use popup window instead of separate pane
let g:go_doc_popup_window = 1

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
