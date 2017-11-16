alias ..='cd ..'
alias ...='cd ../..'

# Some ls aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias lla='ls -AlF'
alias la='ls -A'
alias l='ls -CF'
alias l1='ls -1'
alias la1='ls -A1'

# grep
alias grep='grep --color=auto --exclude-dir=.git --exclude=tags --exclude=*.swp'
alias cgrep='grep --color=always --exclude-dir=.git --exclude=tags --exclude=*.swp'

# Get colourful diffs with correct tabstops
alias diff='diff --color --tabsize=4'

# Get colour for diffstat
alias diffstat='diffstat -C'

# Calendar in a normal, non-stupid format. Weeks start on Monday!
alias cal='ncal -bM'

# Syntax highlighting for bashdb
alias bashdb='bashdb --highlight'

# Is the internet on fire?
alias iiof='dig +short txt istheinternetonfire.com | fmt'

# xclip to Ctrl-V-able clipboard
alias xclips='xclip -selection clipboard'

# Local alias definitions
if [[ -f $HOME/.aliases_local.sh ]]; then
    . "$HOME/.aliases_local.sh"
fi
