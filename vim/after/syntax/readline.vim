syn keyword readlineVariable    contained
                              \ nextgroup=readlineBoolean
                              \ skipwhite
                              \ blink-matching-paren
                              \ enable-bracketed-paste
                              \ colored-stats

if exists("readline_has_bash")
  syn keyword readlineFunction  contained
                              \ shell-forward-word
                              \ shell-backward-word
endif
