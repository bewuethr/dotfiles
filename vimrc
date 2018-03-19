execute pathogen#infect()

" Indentation
set shiftwidth=4 softtabstop=4 tabstop=4 expandtab

" Colours
let g:solarized_termtrans = 1
let g:solarized_old_cursor_style = 1
let g:solarized_term_italics = 1
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
colorscheme solarized8_dark

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

" Calendar.vim settings
let g:calendar_monday = 1

" Lion.vim settings
let g:lion_squeeze_spaces = 1

" Ale settings
let g:ale_sh_shellcheck_options = '-x'

" Pandoc settings
let g:pandoc#modules#disabled = ["folding"]

" Local settings
if filereadable(expand("~/.vimrc_local"))
    source ~/.vimrc_local
endif
