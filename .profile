# asdf variables
export ASDF_CONFIG_FILE="$HOME/.config/asdf/asdfrc"
export ASDF_DIR="$HOME/.local/opt/asdf"
export ASDF_DATA_DIR="$HOME/.local/share/asdf"
export ASDF_GEM_DEFAULT_PACKAGES_FILE="$HOME/.config/asdf/default-gems"

# Custom Docker config directory location
export DOCKER_CONFIG="$HOME/.config/docker"

# Add directories for executables to PATH if they aren't there yet
for dir in "$HOME/.local/bin" "$ASDF_DATA_DIR/shims"; do
	if [ -d "$dir" ]; then
		case :${PATH:=$dir}: in
			*:"$dir":*) ;;
			*) PATH=$dir:$PATH ;;
		esac
	fi
done

unset dir

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
