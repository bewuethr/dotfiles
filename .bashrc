# If not running interactively, don't do anything, else set flow control
case $- in
	*i*) stty -ixon ;;
	*) return ;;
esac

# Old Bash gets very confused
if [[ $BASH_VERSION == [1-3]* ]]; then
	return
fi

# Make less more friendly for non-text input files
if [[ -x /usr/bin/lesspipe ]]; then
	eval "$(SHELL=/bin/sh lesspipe)"
elif [[ -x /usr/local/bin/lesspipe.sh ]]; then
	eval "$(SHELL=/bin/sh lesspipe.sh)"
fi

# Show verbose prompt, reduce tabs, handle escape chars, case insensitive
# search, exit if output fits on a single screen
export LESS='--LONG-PROMPT --tabs=4 --RAW-CONTROL-CHARS --ignore-case --quit-if-one-screen'

# Define default editor for C-x C-e and fc
export VISUAL='vim'
export EDITOR='vim'
export FCEDIT='vim'

# Colours for grep results
export GREP_COLORS='mt=01;31:sl=:cx=00;38;5;10:fn=38;2;108;113;196:ln=32:bn=35:se=33'

# Use this history file
HISTFILE="$HOME/.local/share/bash/history"

# Don't put lines starting with spaces and repeated commands into history
HISTCONTROL='ignoreboth'

# Save multi-line commands in the same history entry
shopt -s cmdhist

# Save multi-line commands with embedded newlines
shopt -s lithist

# Let me try again if I mess up a history substitution
shopt -s histreedit

# Show me the history expansion before running the command
shopt -s histverify

# Unlimited history
HISTSIZE=-1
HISTFILESIZE=-1

# Don't need to store these
HISTIGNORE='exit:history:l:l[1als]:lla:+(.)'

# Timestamps for history
HISTTIMEFORMAT='%F %T '

# Sync history across sessions
PROMPT_COMMAND=('history -a' 'history -c' 'history -r' "${PROMPT_COMMAND[@]}")

# Keep LINES and COLUMNS up to date
shopt -s checkwinsize

# Enable ** glob pattern
shopt -s globstar

# Prevent Ctrl-D (EOF) from exiting shell
set -o ignoreeof

# Set variable identifying the chroot you work in (used in the prompt below)
if [[ -z ${debian_chroot:-} ]] && [[ -r /etc/debian_chroot ]]; then
	debian_chroot=$(< /etc/debian_chroot)
fi

# Check for colour
if type tput &> /dev/null; then
	color_prompt='yes'
else
	color_prompt=
fi

# Enable color support of ls
if type dircolors &> /dev/null; then
	if [[ -r $HOME/.config/dircolors ]]; then
		eval "$(dircolors -b "$HOME/.config/dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

# Set custom prompt if present
if [[ $color_prompt == 'yes' ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.myprompt.bash"
	PROMPT_COMMAND=('set_prompt' "${PROMPT_COMMAND[@]}")
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# Enable programmable completion if we're not in POSIX mode
if ! shopt -oq posix; then
	if [[ -f /usr/share/bash-completion/bash_completion ]]; then
		# shellcheck source=/dev/null
		. /usr/share/bash-completion/bash_completion
	elif [[ -f /usr/local/opt/bash-completion@2/share/bash-completion/bash_completion ]]; then
		# shellcheck source=/dev/null
		. /usr/local/opt/bash-completion@2/share/bash-completion/bash_completion
	fi
fi

# Source asdf
# shellcheck source=/dev/null
source "$ASDF_DIR/asdf.sh"

# Alias definitions
if [[ -f $HOME/.aliases.sh ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.aliases.sh"
fi

# Source custom utility functions
if [[ -f $HOME/.functions.bash ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.functions.bash"
fi

# Local settings
if [[ -r $HOME/.bashrc_local ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.bashrc_local"
fi
