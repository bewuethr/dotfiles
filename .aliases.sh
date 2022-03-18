alias ..='cd ..'
alias ...='cd ../..'

# Some ls aliases
alias ls='ls --color=auto'                # Default: add colour unless in pipe
alias lsd='ls --group-directories-first'  # Directories first
alias l1='ls -1'                          # One file per line
alias l='ls -C --classify'                # By columns, append type indicator

alias la='ls --almost-all'                # Show dotfiles, but not . and ..
alias la1='la -1'                         # Show dotfiles, one per line
alias lad='la --group-directories-first'  # Show dotfiles, directories first

alias ll='ls -l'                                        # Long listing format
alias lla='ll --almost-all'                             # Long listing with dotfiles
alias llad='ll --almost-all --group-directories-first'  # Long with dofiles, dirs first

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
alias man='MANWIDTH=$((COLUMNS > 120 ? 120 : COLUMNS)) man -P "less $LESS"'

# Prettier od
alias od='od -A x -t x1z -v'

# Use my style file for mdl
alias mdl='mdl --style ~/.config/mdl/style.rb'

# Connect and disconnect Sonos speaker
alias btcon='bluetoothctl <<< "connect 5C:AA:FD:D4:EB:84"'
alias btuncon='bluetoothctl <<< disconnect'

# Local alias definitions
if [[ -f $HOME/.aliases_local.sh ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.aliases_local.sh"
fi
