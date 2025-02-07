# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#basic aliases
alias myip='curl http://ipecho.net/plain; echo'
alias r='reset'
mcd () {
    mkdir -p $1
    cd $1
}

#git aliases
alias s='git status'
alias b='git branch'
alias a='git add .'
alias p='git push'
alias d='git diff'
alias pull='git pull'
alias push='git push'
checkout(){
	git checkout $1
}
cm(){
	git commit -m \'$1\'
}
alias a='git add .'
alias log='git log'
c(){
	git commit -m "$1"
}

#gp aliases
alias api='cd ~/code/toolkit-api'
alias gui='cd ~/code/toolkit-ui'
alias fun='cd ~/code/toolkit-functions'
alias com='cd ~/code/toolkit-models'
alias apidev="api && npm run start:dev"
alias guidev="gui && npm run dev"
killonport(){
	fuser -k -n tcp $1
}

alias okta="flatpak run com.okta.developer.CLI"

#ts aliases
alias tsn="ts-node"
alias tnode="ts-node"
alias tsnode="ts-node"