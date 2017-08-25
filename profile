# If running bash
if [ -n "$BASH_VERSION" ]; then
    # Include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Add $HOME/bin to PATH if it isn't there yet
if [ -d "$HOME/bin" ]; then
    case :${PATH:=$HOME/bin}: in
        *:"$HOME/bin":*) ;;
        *) PATH=$HOME/bin:$PATH ;;
    esac
fi

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Show verbose prompt, reduce tabs, handle escape chars, case insensitive search
export LESS='--LONG-PROMPT --tabs=4 --RAW-CONTROL-CHARS --ignore-case'

# Define default editor for C-x C-e and fc
export VISUAL='vim'
export EDITOR='vim'
export FCEDIT='vim'

# Colours for grep results
export GREP_COLORS='mt=01;31:sl=:cx=00;38;5;10:fn=38;2;108;113;196:ln=32:bn=35:se=33'

# Local settings
if [ -r "$HOME/.profile_local" ]; then
    . "$HOME/.profile_local"
fi
