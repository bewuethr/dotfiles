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
alias cgrep='grep --color=always'

# Get colour for diffstat
alias diffstat='diffstat -C'

# Is the internet on fire?
alias iiof='dig +short txt istheinternetonfire.com | fmt'

# Avoid super wide man pages
alias man='MANWIDTH=$((COLUMNS > 120 ? 120 : COLUMNS)) man'

# Local alias definitions
if [[ -f $HOME/.aliases_local.sh ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.aliases_local.sh"
fi
