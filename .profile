# Add $HOME/bin to PATH if it isn't there yet
if [ -d "$HOME/bin" ]; then
	case :${PATH:=$HOME/bin}: in
		*:"$HOME/bin":*) ;;
		*) PATH=$HOME/bin:$PATH ;;
	esac
fi

# Local settings
if [ -r "$HOME/.profile_local" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.profile_local"
fi

# If running bash
if [ -n "$BASH_VERSION" ]; then
	# Include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		# shellcheck source=/dev/null
		. "$HOME/.bashrc"
	fi
fi

# vim:ft=sh
