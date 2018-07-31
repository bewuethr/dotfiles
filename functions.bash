# Find lexically last directory that starts with provided parameter and cd into it
cdl () {
	local cands=("$1"*/)
	# shellcheck disable=SC2164
	cd "${cands[-1]}"
}

# Fold text file at spaces to 80 columns
wrap () {
	fold --spaces "$1" > "$1".$$ && mv "$1".$$ "$1"
}

# Filter for percent encoding - encodes space as "%20" and not as "+"
percentencode () {
	local line i res
	local re='[]:/?#@!$&'"'"'()*+,;=% []'
	while IFS= read -r line; do
		for (( i = 0; i < ${#line}; ++i )); do
			local l=${line:i:1}
			if [[ $l =~ $re ]]; then
				res+=$(printf '%%%02X' "'$l")
			else
				res+=$l
			fi
		done
		printf '%s\n' "$res"
	done < "${1:-/dev/stdin}"
}

# Local function definitions
if [[ -f $HOME/.functions_local.bash ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.functions_local.bash"
fi
