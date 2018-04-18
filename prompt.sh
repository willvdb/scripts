build_prompt() {
	## functions ##
	git_branch() {
		if git branch &> /dev/null; then
			local BRANCH_NAME=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
			if ! [ -z $BRANCH_NAME ]; then
				echo -en "$BRANCH$BRANCH_NAME"
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

	wrap() {
		if [ ${#1} -gt 10 ]; then
			local SEGMENT=$(echo -en "$LEFT_BRACKET$@$RIGHT_BRACKET")
			echo -en `ansi --bg-black "$SEGMENT"`
		fi
	}

	## Icon Config ##
	local LEFT_BRACKET=`ansi --yellow $(echo -e "[")`
	local RIGHT_BRACKET=`ansi --yellow $(echo -e "]")`
	local SEPARATOR=`ansi --yellow $(echo -e ":")`
	local BRANCH=`ansi --bold $(echo -e "\u2387\u2003")`
	local PROFILE=`ansi --bold $(echo -e "\U0001F464\u2003")`
	local DIRECTORY=`ansi --bold $(echo -e "\U0001F5C1\u3000")`
	local SUCCESS=`ansi --bold $(echo -e "\u2713")`
	local FAIL=`ansi --bold $(echo -e "\u2717")`
	## Adding a color to the arrow will cause scrollback to break... ##
	local ARROW=$(echo -e "\u27a4")
	local ARROW=$(echo -e "\U0001f896")
	local ARROW=$(echo -e "\U0001f836")

	## Segment Config ##
	local LAST_NUMBER=$(ansi --yellow "\#")
	local LAST_OUTCOME=""
	local USER=$(ansi --green "$PROFILE$USER")
	local DIR=$(ansi --blue "$DIRECTORY\w")
	local GIT_BRANCH=$(ansi --magenta $(git_branch))
	local GIT_CHANGES=$(ansi --yellow $(git_changes))
	local PROMPT=$(echo -e "\n$ARROW ")

	## Determine Command Outcome ##
	if [[ $? == 0 ]]; then
		LAST_OUTCOME=$(ansi --green $SUCCESS)
	else
		LAST_OUTCOME=$(ansi --red $FAIL)
	fi

	## Highlight Root ##
	if [ `whoami` == 'root' ]; then
		USER=`ansi --red "$USER"`
	fi

	# print the prompt; use this if you're enabling PROMPT_COMMAND
	#echo -e $PROMPT

	# set the PS1 variable; use this if you're not enabling PROMPT_COMMAND
	PS1=$(wrap $LAST_NUMBER$SEPARATOR$LAST_OUTCOME)$(wrap $USER)$(wrap $DIR)$(wrap $GIT_BRANCH)$(wrap $GIT_CHANGES)$PROMPT
}

PROMPT_COMMAND='build_prompt'
