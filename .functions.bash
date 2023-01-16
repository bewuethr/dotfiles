# Find lexically last directory that starts with provided parameter and cd into it
cdl() {
	local cands=("$1"*/)
	# shellcheck disable=SC2164
	cd "${cands[-1]}"
}

# Fold text file at spaces to 80 columns
wrap() {
	fold --spaces "$1" > "$1".$$ && mv "$1".$$ "$1"
}

# Filter for percent encoding - chose between "%20" and "+" for spaces with the
# -p option
percentencode() {
	jq --raw-input --raw-output '@uri'
}

# Install latest version of yq and its man page
yqupgrade() {
	go install github.com/mikefarah/yq/v4@latest
	(
		cd /tmp || exit 1
		gh --repo mikefarah/yq release download --clobber --pattern '*man_page*'
		tar xvf yq_man_page_only.tar.gz
		./install-man-page.sh
	)
}

# Local function definitions
if [[ -f $HOME/.functions_local.bash ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.functions_local.bash"
fi
