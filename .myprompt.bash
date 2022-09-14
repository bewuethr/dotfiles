set_prompt() {
	# Exit status of last command
	local exit_status=$?

	# Colours
	local red green yellow blue magenta cyan orange grey violet lgrey no_colour
	red=$(tput setaf 1)
	green=$(tput setaf 2)
	yellow=$(tput setaf 3)
	blue=$(tput setaf 4)
	magenta=$(tput setaf 5)
	cyan=$(tput setaf 6)
	orange=$(tput setaf 9)
	grey=$(tput setaf 10)
	violet=$(tput setaf 13)
	lgrey=$(tput setaf 14)
	no_colour=$(tput sgr0)

	PS1=

	# Git aware prompt
	# - Check for unstaged (*) and staged changes (+)
	#     - Show how many
	# - Check if something is stashed ($)
	#     - Show how many refs in stash
	# - Check if there are untracked files (%)
	#     - Show how many
	# - Show difference between HEAD and upstream (<,>,<>,=)
	# - Show number of commits ahead/behind upstream (+/-)
	#     - Show if fast-forwardable
	#     - TODO more ways of checking if actually can be fast-forwarded ("dirty state"?)
	# - Colours
	# - Use unicode characters from patched Inconsolata font
	# - ((submodule)) in double parentheses
	# - Prompt during interactive rebasing and similar
	# - Check if in .git tree, or if bare repo
	local git_dir
	if git_dir=$(git rev-parse --git-dir 2> /dev/null); then

		PS1="\\[$grey\\]("

		# Get current branch or just use ".git" if in git directory
		if [[ $(git rev-parse --is-inside-git-dir) == 'true' ]]; then
			# Or is it even a bare repo?
			if [[ $(git rev-parse --is-bare-repository) == 'true' ]]; then
				PS1+='bare'
			else
				PS1+='.git'
			fi

		elif [[ -f $(git rev-parse --show-toplevel)/.git ]]; then
			# We are in a submodule
			__submodname=$(< "$(git rev-parse --show-toplevel)/.git")
			__submodname=${__submodname##*/}
			PS1+="(\\[$lgrey\\]$__submodname\\[$grey\\])"

		elif [[ -d $git_dir/rebase-merge ]]; then
			# We're in an interactive merge/rebase
			if [[ -f $git_dir/rebase-merge/interactive ]]; then
				local step total
				step=$(< "$git_dir/rebase-merge/msgnum")
				total=$(< "$git_dir/rebase-merge/end")
				PS1+="\\[$orange\\]rebase-i $step/$total"
			else
				PS1+="\\[$orange\\]rebase-m $step/$total"
			fi

		elif [[ -d $git_dir/rebase-apply ]]; then
			# We're applying a rebase or mail patch
			local step total head
			step=$(< "$git_dir/rebase-apply/next")
			total=$(< "$git_dir/rebase-apply/last")
			head=$(< "$git_dir/rebase-apply/head-name")
			if [[ -f $git_dir/rebase-apply/rebasing ]]; then
				PS1+="\\[$orange\\]rebase $step/$total \\[$cyan\\]${head##*/}"
			elif [[ -f $git_dir/rebase-apply/applying ]]; then
				PS1+="\\[$orange\\]am $step/$total"
			else
				PS1+="\\[$orange\\]am/rebase $step/$total"
			fi

		elif [[ -f $git_dir/MERGE_HEAD ]]; then
			PS1+="\\[$orange\\]merging"

		elif [[ -f $git_dir/CHERRY_PICK_HEAD ]]; then
			PS1+="\\[$orange\\]cherry-picking"

		elif [[ -f $git_dir/REVERT_HEAD ]]; then
			PS1+="\\[$orange\\]reverting"

		elif [[ -f $git_dir/BISECT_LOG ]]; then
			PS1+="\\[$orange\\]bisecting"

		elif __bname=$(git symbolic-ref -q --short HEAD); then
			# Use variable instead of assigning directly because of expansions vulnerability
			PS1+="\\[$cyan\\]\${__bname}"
			local space=" "

			# Unstaged changes
			local uscct
			if uscct=$(git status --porcelain | grep -c '^.[MD]'); then
				((uscct == 1)) && uscct=
				PS1+="${space:-"\\[$grey\\]|"}\\[$orange\\]$uscct"$'\uf62f' # 
				space=""
			fi

			# Staged changes
			local scct
			if scct=$(git status --porcelain | grep -c '^[MADRC]'); then
				((scct == 1)) && scct=
				PS1+="${space:-"\\[$grey\\]|"}\\[$orange\\]$scct"$'\uf62e' # 
				space=""
			fi

			# Stash
			if git reflog exists refs/stash; then
				local stashct
				stashct=$(git stash list | wc -l)
				((stashct == 1)) && stashct=
				PS1+="${space:-"\\[$grey\\]|"}\\[$blue\\]$stashct"$'\uf62d' # 
				space=""
			fi

			# Untracked files
			local utct
			if utct=$(git status --porcelain | grep -c '^??'); then
				((utct == 1)) && utct=
				PS1+="${space:-"\\[$grey\\]|"}\\[$magenta\\]$utct"$'\uf630' # 
				space=
			fi

			# Commits ahead/behind upstream
			local commits
			if commits=$(git rev-list --left-right HEAD...@\{u\} 2> /dev/null); then
				local ahead
				ahead=$(grep -c '^<' <<< "$commits")
				((ahead > 0)) && {
					PS1+="${space:-"\\[$grey\\]|"}\\[$violet\\]${ahead}"$'\uf63e' # 
					space=
				}

				local behind
				behind=$(grep -c '^>' <<< "$commits")
				local behcol
				if ((behind > 0)); then
					# Check if can be fast-forwarded
					if git merge-base --is-ancestor HEAD '@{u}'; then
						behcol=$yellow
					else
						behcol=$red
					fi
					PS1+="${space:-"\\[$grey\\]|"}\\[$behcol\\]${behind}"$'\uf63b' # 
					space=
				fi

				((ahead == 0 && behind == 0)) && PS1+="${space:-"\\[$grey\\]|"}\\[$green\\]"$'\uf62b' # 
			fi
		else
			# Probably detached HEAD, use describe or commit hash
			# Use variable instead of assigning directly because of expansions vulnerability
			PS1+="\\[$lgrey\\]"
			if __bname=$(git describe --tags HEAD 2> /dev/null); then
				PS1+='${__bname}'
			else
				PS1+=$(git rev-parse --short HEAD)
			fi

		fi
		PS1+="\\[$grey\\]) "
	fi

	# If user name has multiple parts, shorten to 'a_b' or similar; else just use first letter
	local suff
	__un=${USER:0:1}
	if [[ $USER == *?[-._]?* ]]; then
		suff=${USER#*[-._]}
		__un+=${USER:$((${#USER} - ${#suff} - 1)):1}${suff:0:1}
	fi

	# If host name has multiple parts, shorten to 'a-b' or similar; else just use first letter
	__hn=${HOSTNAME:0:1}
	if [[ $HOSTNAME == *?[-._]?* ]]; then
		suff=${HOSTNAME#*[-._]}
		__hn+=${HOSTNAME:$((${#HOSTNAME} - ${#suff} - 1)):1}${suff:0:1}
	fi

	# If $PWD starts with $HOME, replace the $HOME part with a tilde
	if [[ $PWD == "$HOME"* ]]; then
		__cwd="~${PWD:${#HOME}}"
	else
		__cwd=$PWD
	fi

	# Except for the basename, shorten all directories in $PWD to the first 3 letters
	# Use '/' as delimiter because it's the only character not allowed in filenames
	local cwd_arr
	IFS='/' read -ra cwd_arr <<< "${__cwd#/}"
	if ((${#cwd_arr[@]} > 1)); then
		printf -v __cwd '%.3s/' "${cwd_arr[@]:0:$((${#cwd_arr[@]} - 1))}"
		__cwd+=${cwd_arr[-1]%/}
	fi
	# Re-insert leading slash unless we use ~ or /
	if [[ $__cwd != [~/]* ]]; then
		__cwd=/$__cwd
	fi

	local sign_col
	# Colour for prompt sign
	if ((exit_status == 0)); then
		sign_col=$green
	else
		sign_col=$red
	fi

	# Set rest of prompt
	# User and hostname
	PS1+="\\[$blue\\]\$__un\\[$orange\\]@\\[$yellow\\]\$__hn\\[$orange\\]:"

	# Working directory and coloured prompt
	PS1+="\\[$violet\\]\$__cwd\\[$sign_col\\]\\$\\[$no_colour\\] "

	# Set window title: see https://superuser.com/q/249293/372008
}
