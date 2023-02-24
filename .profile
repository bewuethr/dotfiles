# Add $HOME/.local/bin to PATH if it isn't there yet
dir=$HOME/.local/bin
if [ -d "$dir" ]; then
	case :${PATH:=$dir}: in
		*:"$dir":*) ;;
		*) PATH=$dir:$PATH ;;
	esac
fi

unset dir

# asdf variables
export ASDF_CONFIG_FILE="$HOME/.config/asdf/asdfrc"
export ASDF_DIR="$HOME/.local/opt/asdf"
export ASDF_DATA_DIR="$HOME/.local/share/asdf"
export ASDF_GEM_DEFAULT_PACKAGES_FILE="$HOME/.config/asdf/default-gems"

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
