set-window-title() {
  echo -en "\033]0;$(basename $(pwd) | sed -e "s;^$HOME;~;")\a"
}

if [[ "$PROMPT_COMMAND" ]]; then
  export PROMPT_COMMAND="$PROMPT_COMMAND;set-window-title"
else
  export PROMPT_COMMAND=set-window-title
fi