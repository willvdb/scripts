build_prompt() {
	## functions ##
	git_branch() {
		if git branch &> /dev/null; then
			local BRANCH_NAME=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
			if ! [ -z $BRANCH_NAME ]; then
				echo -en "$BRANCH_NAME"
			fi
		fi
	}

	git_changes() {
		if git branch &> /dev/null; then
			local CHANGES=$((`git status | grep -0 'modified\|deleted' | wc -l` + `git ls-files --others --exclude-standard | wc -l`))
			if [ $CHANGES -gt 0 ]; then
				echo -en "$CHANGES"
			fi
		fi
	}

	# Helper function to wrap ANSI codes for PS1
	ps1_escape() {
		echo "\[$1\]"
	}

	wrap() {
		# Only wrap if there's actual content (not just empty or whitespace)
		local CONTENT="$@"
		if [ ! -z "$CONTENT" ] && [ ${#CONTENT} -gt 0 ]; then
			local SEGMENT=$(echo -en "$LEFT_BRACKET$CONTENT$RIGHT_BRACKET")
			echo -en $(ps1_escape "`ansi --bg-black "$SEGMENT"`")
		fi
	}

	## Icon Config ##
	local LEFT_BRACKET=$(ps1_escape "`ansi --yellow $(echo -e "[")`")
	local RIGHT_BRACKET=$(ps1_escape "`ansi --yellow $(echo -e "]")`")
	local SEPARATOR=$(ps1_escape "`ansi --yellow $(echo -e ":")`")
	local BRANCH=$(ps1_escape "`ansi --bold $(echo -e "\u2387\u2003")`")
	local PROFILE=$(ps1_escape "`ansi --bold $(echo -e "\U0001F464\u2003")`")
	local DIRECTORY=$(ps1_escape "`ansi --bold $(echo -e "\U0001F5C1\u3000")`")
	local SUCCESS=$(ps1_escape "`ansi --bold $(echo -e "\u2713")`")
	local FAIL=$(ps1_escape "`ansi --bold $(echo -e "\u2717")`")
	## Adding a color to the arrow will cause scrollback to break... ##
	local ARROW=$(echo -e "\u27a4")
	local ARROW=$(echo -e "\U0001f896")
	local ARROW=$(echo -e "\U0001f836")

	## Segment Config ##
	local LAST_NUMBER=$(ps1_escape "$(ansi --yellow "\#")")
	local LAST_OUTCOME=""
	local USER=$(ps1_escape "$(ansi --green --bold "$USER")")
	local HOSTNAME=$(ps1_escape "$(ansi --magenta --bold --underline "$HOSTNAME")")
	local DIR=$(ps1_escape "$(ansi --blue "\w")")
	
	# Only get git info if we're in a git repository
	local GIT_BRANCH_TEXT=$(git_branch)
	local GIT_CHANGES_TEXT=$(git_changes)
	local GIT_BRANCH=""
	local GIT_CHANGES=""
	
	if [ ! -z "$GIT_BRANCH_TEXT" ]; then
		GIT_BRANCH=$(ps1_escape "$(ansi --magenta "$GIT_BRANCH_TEXT")")
	fi
	
	if [ ! -z "$GIT_CHANGES_TEXT" ]; then
		GIT_CHANGES=$(ps1_escape "$(ansi --yellow "$GIT_CHANGES_TEXT")")
	fi
	
	local PROMPT=$(echo -e "$")

	## Determine Command Outcome ##
	if [[ $? == 0 ]]; then
		LAST_OUTCOME=$(ps1_escape "$(ansi --green $SUCCESS)")
	else
		LAST_OUTCOME=$(ps1_escape "$(ansi --red $FAIL)")
	fi

	## Highlight Root ##
	if [ `whoami` == 'root' ]; then
		USER=$(ps1_escape "`ansi --red "$USER"`")
	fi

	# print the prompt; use this if you're enabling PROMPT_COMMAND
	#echo -e $PROMPT

	# set the PS1 variable; use this if you're not enabling PROMPT_COMMAND
	PS1=$(wrap $LAST_NUMBER$SEPARATOR$LAST_OUTCOME)$(wrap $USER@$HOSTNAME)$(wrap $DIR)$(wrap $GIT_BRANCH)$(wrap $GIT_CHANGES)$PROMPT
}

PROMPT_COMMAND='build_prompt'
