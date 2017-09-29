# If not running interactively, don't do anything, else set flow control
case $- in
    *i*)    stty -ixon ;;
    *)      return ;;
esac

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
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

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
if [[ -x /usr/bin/tput ]] && tput setaf 1 &> /dev/null; then
    color_prompt='yes'
else
    color_prompt=
fi

# Enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    if [ -r "$HOME/.dircolors" ]; then
        eval "$(dircolors -b "$HOME/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi
fi

# Set custom prompt if present
if [[ $color_prompt = 'yes' ]]; then
    . "$HOME/.myprompt.bash"
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}set_prompt"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# Enable programmable completion if we're not in POSIX mode
if ! shopt -oq posix && [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
fi

# Alias definitions.
if [[ -f $HOME/.aliases.sh ]]; then
    . "$HOME/.aliases.sh"
fi

# Source custom utility functions
if [[ -f $HOME/.functions.bash ]]; then
    . "$HOME/.functions.bash"
fi

# Local settings
if [ -r "$HOME/.bashrc_local" ]; then
    . "$HOME/.bashrc_local"
fi
