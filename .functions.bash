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
	local usage='Usage: percentencode [-h|-p] STRING [STRING...]'
	local opt
	local p
	OPTIND=1
	while getopts ':hp' opt; do
		case $opt in
			h) printf '%s\n' "$usage" >&2 && return 1 ;;
			p) p='yes' ;;
			*) printf 'Invalid option: %s\n%s\n' "$OPTARG" "$usage" >&2 && return 1 ;;
		esac
	done
	shift "$((OPTIND - 1))"

	if (($# == 0)); then
		printf '%s\n' "$usage" >&2
		return 1
	fi

	local str i j res
	local re='[]:/?#@!$&'"'"'()*+,;=% []'
	i=0
	for str in "$@"; do
		for ((j = 0; j < ${#str}; ++j)); do
			local l=${str:j:1}
			if [[ $l =~ $re ]]; then
				res[i]+=$(printf '%%%02X' "'$l")
			else
				res[i]+=$l
			fi
		done
		((++i))
	done

	# Check if spaces should be "+"
	if [[ $p ]]; then
		printf '%s\n' "${res[*]//%20/+}"
	else
		printf '%s\n' "${res[*]}"
	fi
}

# Local function definitions
if [[ -f $HOME/.functions_local.bash ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.functions_local.bash"
fi
