syn keyword readlineVariable contained
                           \ nextgroup=readlineBoolean
                           \ blink-matching-paren
                           \ colored-completion-prefix
                           \ enable-bracketed-paste

syn keyword readlineFunction contained
                           \ print-last-kbd-macro

if exists("readline_has_bash")
	syn keyword readlineFunction contained
	                           \ shell-forward-word
	                           \ shell-backward-word
	                           \ shell-kill-word
	                           \ shell-backward-kill-word
endif
