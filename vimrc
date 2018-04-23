execute pathogen#infect()

" Indentation
set shiftwidth=4 softtabstop=4 tabstop=4 expandtab

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

" Plugins

" Vimwiki settings
let g:vimwiki_list = [{'maxhi': 1, 'list_margin': 0, 'auto_toc': 1, 'auto_tags': 1}]
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_html_header_numbering = 2

" Calendar.vim settings
let g:calendar_monday = 1

" Lion.vim settings
let g:lion_squeeze_spaces = 1

" Ale settings
let g:ale_sh_shellcheck_options = '-x'

" Pandoc settings
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#syntax#codeblocks#embeds#langs = ["bash=sh", "sh"]

" vim-go settings
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" fugitive.vim settings
set statusline=%f\ %{fugitive#statusline()}

" Local settings
if filereadable(expand("~/.vimrc_local"))
    source ~/.vimrc_local
endif
