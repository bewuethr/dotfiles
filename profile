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

# Local settings
if [ -r "$HOME/.profile_local" ]; then
    . "$HOME/.profile_local"
fi

# vim:ft=sh
