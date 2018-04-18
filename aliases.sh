# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#basic aliases
alias source='cd ~/git/source'
alias modskin='cd ~/git/source/modular_skin'
alias bankfour='cd ~/git/source/bank_fouritem'
alias bankfourmuscle='cd ~/git/source/bank_4muscle'
alias createbank='node ~/scripts/bank/bank'
alias codechallenges='cd ~/git/source/code-challenges'
alias myip='curl http://ipecho.net/plain; echo'
alias r='reset'
mcd () {
    mkdir -p $1
    cd $1
}

#git aliases
gitclone(){
	git clone git@github.com:ipartnr8/$1
}
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

#trapeze aliases
alias gui='cd ~/source/trapeze-gui'
alias payments='cd ~/git/source/circus-trapeze-payments-gui'
killonport(){
	fuser -k -n tcp $1
}
