alias ..='cd ..'
alias ...='cd ../..'

# Some ls aliases
alias l1='ls -1'
alias l='ls -CF'
alias la1='ls -A1'
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -AlF'
alias ls='ls --color=auto'
alias lsd='ls --group-directories-first'

# Git for dotfiles
alias gdf='git --git-dir="$HOME/.dotfiles.git" --work-tree="$HOME"'

# grep
alias grep='grep --color=auto --exclude-dir=.git --exclude=tags --exclude=*.swp'
alias cgrep='grep --color=always'

# Get colour for diffstat
alias diffstat='diffstat -C'

# Is the internet on fire?
alias iiof='dig +short txt istheinternetonfire.com | fmt'

# Avoid super wide man pages
alias man='MANWIDTH=$((COLUMNS > 120 ? 120 : COLUMNS)) man'

# Prettier od
alias od='od -A x -t x1z -v'

# Local alias definitions
if [[ -f $HOME/.aliases_local.sh ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.aliases_local.sh"
fi
