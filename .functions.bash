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

# Filter for percent encoding
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

# Install latest version of asdf
upgradeasdf() {
	gh --repo asdf-vm/asdf release download --clobber \
		--pattern 'asdf-*-linux-amd64.tar.gz' \
		--output - \
		| tar xzvf - --directory "$HOME/.local/bin"
	asdf --version
}

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

# Install latest version of buildifier
upgradebuildifier() {
	gh --repo bazelbuild/buildtools release download --clobber \
		--pattern 'buildifier-linux*amd64' \
		--output "$HOME/.local/bin/buildifier"
	chmod +x "$HOME/.local/bin/buildifier"
	buildifier -version
}

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

# Install latest version of freeze
upgradefreeze() {
	gh --repo charmbracelet/freeze release download \
		--pattern 'freeze_*_Linux_x86_64.tar.gz' \
		--output - \
		| tar xzvf - \
			--directory="$HOME/.local/bin" \
			--wildcards 'freeze_*/freeze' \
			--transform 's/^freeze.*\///'
	freeze
}

# Install latest version of gems and bundler, and apply to Swiss Club website
upgradegems() (
	cd "$HOME/dev/swissclubto/swissclubto.github.io" || exit 1
	git pull
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

# Upgrade Go to latest
upgradego() {
	local version
	local statuscode

	version=$(curl --silent https://go.dev/dl/?mode=json \
		| jq --raw-output 'first.version')

	statuscode=$(curl \
		--head \
		--silent \
		--write-out '%{response_code}' \
		--output /dev/null \
		"https://dl.google.com/go/$version.linux-amd64.tar.gz")

	if ((statuscode != 200)); then
		echo "$version does not exist" >&2
		return 1
	fi

	curl \
		--progress-bar \
		--output "go$version.tar.gz" \
		"https://dl.google.com/go/$version.linux-amd64.tar.gz"

	sudo rm --recursive --force /usr/local/go
	sudo tar --directory=/usr/local --extract --file="go$version.tar.gz"
	rm "go$version.tar.gz"

	go version
}

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

# Install latest version of hadolint
upgradehadolint() {
	gh --repo hadolint/hadolint release download --clobber \
		--pattern 'hadolint-linux-x86_64' \
		--output "$HOME/.local/bin/hadolint"
	chmod +x "$HOME/.local/bin/hadolint"
	hadolint --version
}

# Install latest version of hexyl
upgradehexyl() (
	cd /tmp || exit 1
	gh --repo sharkdp/hexyl release download --clobber \
		--pattern 'hexyl_*_amd64.deb' \
		--output 'hexyl.deb'
	sudo dpkg --install hexyl.deb
	hexyl --version
)

# Install latest version of hledger
upgradehledger() (
	cd /tmp || exit 1
	gh --repo simonmichael/hledger release download --clobber \
		--pattern 'hledger-linux-x64.tar.gz' \
		--output 'hledger.tar.gz'
	tar xvf hledger.tar.gz
	mv hledger hledger-ui hledger-web "$HOME/.local/bin"
	mv hledger.1 hledger-ui.1 hledger-web.1 "$HOME/.local/share/man/man1"
	mv hledger.info hledger-ui.info hledger-web.info "$HOME/.local/share/info"

	# shellcheck disable=SC2016
	sed '
		s/\(complete -F _hledger_completion\) hledger/\1 hla/
		s/\(complete -F _hledger_extension_completion\) hledger-ui hledger-web/\1 hla-ui hla-web/
		s/\(local ext=${cmd#\)hledger\(-}\)/\1hla\2/
		s/\(COMP_WORDS=("\)hledger\(" "\$ext" "\${COMP_WORDS\[@\]:1}")\)/\1hla\2/
	' hledger-completion.bash > "$HOME/.local/share/bash-completion/completions/hla"
	mv hledger-completion.bash "$HOME/.local/share/bash-completion/completions/hledger"
	hledger --version
	hledger-ui --version
	hledger-web --version
)

# Install latest version of ijq
upgradeijq() (
	cd /tmp || exit 1
	rm -rf ijq
	gh repo clone gpanders/ijq
	cd ijq || exit 1
	make "PREFIX=$HOME/.local" install
	ijq -V
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
		--pattern 'jqp_Linux_x86_64.tar.gz' \
		--output 'jqp.tar.gz'
	tar xvf jqp.tar.gz
	mv jqp "$HOME/.local/bin"
	jqp --version
)

# Install latest version of neovim
upgradenvim() (
	cd /tmp || exit 1
	gh --repo neovim/neovim release download --clobber \
		--pattern 'nvim-linux-x86_64.appimage' \
		--output 'nvim.appimage'
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

# Install latest version of shfmt and its manpage
upgradeshfmt() {
	gh --repo mvdan/sh release download --clobber \
		--pattern 'shfmt_*_linux_amd64' \
		--output "$HOME/.local/bin/shfmt"
	chmod +x "$HOME/.local/bin/shfmt"
	gh api repos/mvdan/sh/contents/cmd/shfmt/shfmt.1.scd \
		--jq '.content | @base64d' \
		| scdoc > "$HOME/.local/share/man/man1/shfmt.1"
	shfmt --version
}

# Install latest version of Tilt
upgradetilt() (
	cd /tmp || exit 1
	gh --repo tilt-dev/tilt release download --clobber \
		--pattern 'tilt.*.linux.x86_64.tar.gz' \
		--output - \
		| tar xzvf - --directory "$HOME/.local/bin" tilt
	tilt version
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

# Install latest version of xsv
upgradexsv() (
	cd /tmp || exit 1
	gh --repo BurntSushi/xsv release download --clobber \
		--pattern 'xsv-*-x86_64-unknown-linux-musl.tar.gz' \
		--output 'xsv.tar.gz'
	tar xvf xsv.tar.gz
	mv xsv "$HOME/.local/bin"
	xsv --version
)

# Call hledger for all journal files
hla() {
	hledger \
		--file="$HOME/dev/ledger/2025.journal" \
		--file="$HOME/dev/ledger/2026.journal" \
		"$@" not:tag:clopen
}

hla-ui() {
	hledger-ui \
		--file="$HOME/dev/ledger/2025.journal" \
		--file="$HOME/dev/ledger/2026.journal" \
		"$@" not:tag:clopen
}

hla-web() {
	hledger-web \
		--file="$HOME/dev/ledger/2025.journal" \
		--file="$HOME/dev/ledger/2026.journal" \
		"$@" not:tag:clopen
}

# Local function definitions
if [[ -f $HOME/.functions_local.bash ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.functions_local.bash"
fi
