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

# Install latest version of actionlint
upgradeactionlint() (
	cd /tmp || exit 1
	gh --repo rhysd/actionlint release download --clobber \
		--pattern 'actionlint_*_linux_amd64.tar.gz' \
		--output 'actionlint.tar.gz'
	tar xvf actionlint.tar.gz
	mv actionlint "$HOME/.local/bin"
	mv man/actionlint.1 "$HOME/.local/share/man/man1"
	actionlint --version
)

# Install latest version of bat
upgradebat() (
	cd /tmp || exit 1
	gh --repo sharkdp/bat release download --clobber \
		--pattern 'bat_*_amd64.deb' \
		--output 'bat.deb'
	sudo dpkg --install bat.deb
	bat --version
)

# Install latest version of delta
upgradedelta() (
	cd /tmp || exit 1
	gh --repo dandavison/delta release download --clobber \
		--pattern 'git-delta_*_amd64.deb' \
		--output 'delta.deb'
	sudo dpkg --install delta.deb
	delta --version
)

# Install latest version of golangci-lint
upgradegolangci-lint() (
	cd /tmp || exit 1
	gh --repo golangci/golangci-lint release download --clobber \
		--pattern 'golangci-lint-*-linux-amd64.deb' \
		--output 'golangci-lint.deb'
	sudo dpkg --install golangci-lint.deb
	golangci-lint version
)

# Install latest version of gitleaks
upgradegitleaks() (
	cd /tmp || exit 1
	gh --repo gitleaks/gitleaks release download --clobber \
		--pattern 'gitleaks_*_linux_x64.tar.gz' \
		--output 'gitleaks.tar.gz'
	tar xvf gitleaks.tar.gz
	mv gitleaks "$HOME/.local/bin"
	gitleaks version
)

# Install latest version of jqp
upgradejqp() (
	cd /tmp || exit 1
	gh --repo noahgorstein/jqp release download --clobber \
		--pattern 'jqp_*_Linux_x86_64.tar.gz' \
		--output 'jqp.tar.gz'
	tar xvf jqp.tar.gz
	mv jqp "$HOME/.local/bin"
	jqp --version
)

# Install latest version of shfmt
upgradeshfmt() {
	gh --repo mvdan/sh release download --clobber \
		--pattern 'shfmt_*_linux_amd64' \
		--output "$HOME/.local/bin/shfmt"
	chmod +x "$HOME/.local/bin/shfmt"
	shfmt --version
}


# Install latest version of yq and its man page
upgradeyq() (
	cd /tmp || exit 1
	gh --repo mikefarah/yq release download --clobber \
		--pattern 'yq_linux_amd64.tar.gz'
	tar xvf yq_linux_amd64.tar.gz
	mv yq_linux_amd64 "$HOME/.local/bin/yq"
	./install-man-page.sh
	yq --version
)

# Local function definitions
if [[ -f $HOME/.functions_local.bash ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.functions_local.bash"
fi
