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

# Install latest version of AWS CLI
upgradeaws() (
	cd /tmp || exit 1
	curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' --output 'awscliv2.zip'
	unzip awscliv2.zip
	sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
	rm -rf aws
	aws --version
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

# Install latest version of bats
upgradebats() (
	cd /tmp || exit 1
	gh --repo bats-core/bats-core release download \
		--archive tar.gz --output - \
		| tar xzvf - --transform 's/^bats-core[^\/]*/bats-core/'
	cd bats-core || exit 1
	sudo ./install.sh /usr/local
	bats --version
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

# Install latest version of duf
upgradeduf() (
	cd /tmp || exit 1
	gh --repo muesli/duf release download --clobber \
		--pattern 'duf_*_linux_amd64.deb' \
		--output 'duf.deb'
	sudo dpkg --install duf.deb
	duf --version
)

# Install latest version of gems and bundler, and apply to Swiss Club website
upgradegems() (
	cd "$HOME/dev/swissclubto/swissclubto.github.io" || exit 1
	local gv bv
	gem update --system
	gv=$(gem --version)
	echo "$gv"
	bundle update --bundler
	bv=$(bundle --version)
	echo "$bv"
	local wf='.github/workflows/deploy.yml'
	gv="$gv" yq '.jobs.build.steps[1].with.rubygems |= env(gv)' "$wf" \
		| diff --ignore-all-space --ignore-blank-lines "$wf" - \
		| patch "$wf" -
	git diff
	git add "$wf" Gemfile.lock
	git commit --message "Bump gems to $gv and bundler to ${bv#Bundler version }"
	if gum confirm "Push?"; then git push; fi
)

upgradegocomplete() (
	cd /tmp || exit 1
	gh --repo posener/complete release download \
		--archive tar.gz --output - \
		| tar xzvf - --transform 's/^complete[^\/]*/complete/'
	cd complete/gocomplete || exit 1
	go build
	mv gocomplete "$HOME/.local/bin"
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

# Install latest version of jq
upgradejq() (
	cd /tmp || exit 1
	gh --repo jqlang/jq release download --clobber \
		--pattern 'jq-linux-amd64' \
		--output "$HOME/.local/bin/jq"
	chmod +x "$HOME/.local/bin/jq"
	rm -rf jq
	gh repo clone jqlang/jq
	cd jq || exit 1
	git submodule update --init
	autoreconf -i
	./configure # --with-oniguruma=builtin
	make --jobs=8
	# make jq.1
	mv jq.1 "$HOME/.local/share/man/man1"
	jq --version
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

# Install latest version of neovim
upgradenvim() (
	cd /tmp || exit 1
	gh --repo neovim/neovim release download --clobber \
		--pattern 'nvim.appimage'
	chmod u+x nvim.appimage
	mv nvim.appimage "$HOME/.local/bin/nvim"
	nvim --version
)

# Install latest version of pandoc
upgradepandoc() (
	cd /tmp || exit 1
	gh --repo jgm/pandoc release download --clobber \
		--pattern 'pandoc-*-amd64.deb' \
		--output 'pandoc.deb'
	sudo dpkg --install pandoc.deb
	pandoc --version
)

# Install latest version of ShellCheck
upgradeshellcheck() (
	cd /tmp || exit 1
	repo='koalaman/shellcheck'
	gh --repo "$repo" release download --clobber \
		--pattern 'shellcheck-*.linux.x86_64.tar.xz' \
		--output 'shellcheck.tar.xz'
	tar xf shellcheck.tar.xz --transform 's/^shellcheck[^\/]*/shellcheck/'
	cd shellcheck || exit 1
	tag=$(gh --repo "$repo" release view --json tagName --jq '.tagName')
	manfile='shellcheck.1.md'
	gh api "repos/$repo/contents/$manfile?ref=$tag" --jq '.content | @base64d' > "$manfile"
	pandoc -s -f markdown-smart -t man shellcheck.1.md -o shellcheck.1
	sudo mv shellcheck /usr/local/bin
	sudo mv shellcheck.1 /usr/local/share/man/man1
	shellcheck --version
)

# Install latest version of shfmt
upgradeshfmt() {
	gh --repo mvdan/sh release download --clobber \
		--pattern 'shfmt_*_linux_amd64' \
		--output "$HOME/.local/bin/shfmt"
	chmod +x "$HOME/.local/bin/shfmt"
	shfmt --version
}

# Install latest version of tmux
upgradetmux() (
	cd /tmp || exit 1
	gh --repo tmux/tmux release download --clobber \
		--pattern 'tmux-*.tar.gz' \
		--output 'tmux.tar.gz'
	tar xf tmux.tar.gz --transform 's/^tmux[^\/]*/tmux/'
	cd tmux || exit 1
	./configure && make
	sudo make install
	tmux -V
)

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
