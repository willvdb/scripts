syncscripts() {
	CD=$(pwd)
	git --version > /dev/null 2>&1 || { echo >&2 "Git isn't installed... Aborting"; exit 1; }
	cd ~/.scripts
	git pull
	git commit -am"autosync $(date)"
	git push
	cd $CD
	source ~/.bashrc
}

userprocs() {
 ps aux | awk '/'$1'/ { print $2}'
}

fman(){ man $@ | gedit;}

gkill(){ for p in `pgrep $@`; do kill $p; done;}

countmail(){ zenity --info --text=$(zenity --text-info --editable --title="paste in exim log" | grep "<=" | wc -l)" emails sent";}

countspam(){
if [ -z $@ ]; then dom=$(zenity --entry --text "enter domains, separated by |");else dom=$@;fi
list=$(zenity --text-info --editable --title="paste in exim log" |
egrep -o "<=.{1,30}@($dom)" | sort | uniq -c | sort -nr | sed -e 's/\(\d+ <=\)/\n\1/')
echo "$list" | zenity --text-info --title "Sending Totals" &
}

uptime() {
_time=$(awk -F '.' '{print $1}' /proc/uptime)
`printf "$_time\n" | egrep "[^0-9]" 1>/dev/null 2>&1`
if   [ $? != 1 ];then
	printf "the arg passed to the script contains\n"
	printf "non-numerical characters, i'm exiting\n"
	exit 98
fi
	_days=`printf "scale=0;$_time / 86400\n" | bc -l`
	_hours=`printf "scale=0;($_time / 3600) - ($_days * 24)\n"  | bc -l `
	_minutes=`printf "scale=0;($_time / 60) - ($_days * 1440) - ($_hours * 60)\n" | bc -l`
	_seconds=`printf "scale=0;$_time %% 60\n" | bc -l`
printf "${_days:-0}D ${_hours:-0}H "
printf "${_minutes:-0}M ${_seconds:-0}S\n"
}

pagespeed(){
for i in ${@}; do
	local site=$1
	echo $site
	echo ${site} | sed -n 's/./-/gp'
	curl -w '
	Lookup time:\t%{time_namelookup} s
	Connect time:\t%{time_connect} s
	Pre-transfer time:\t%{time_pretransfer} s
	Time to first packet:\t%{time_starttransfer} s
	Size download:\t%{size_download} bytes
	Speed download:\t%{speed_download} bytes/s

	Total time:\t%{time_total} s
	' -o /dev/null -s $site
	echo
done
}
progress(){
	[[ -z $1 || -z $2 || -z $3 ]] && exit  # on empty param...

	percent=$3
	completed=$(( $percent / 2 ))
	remaining=$(( 50 - $completed ))

	echo -ne "\r\t["
	printf "%0.s=" `seq $completed`
	echo -n ">"
	[[ $remaining != 0 ]] && printf "%0.s." `seq $remaining`
    echo -n "] $percent% ($2)  "
}
typewriter(){
	text="$1"
	if [[ -z $2 ]];then  delay=0.01
	else delay="$2"; fi
	for i in $(seq 0 $(expr length "${text}")) ; do
		echo -ne "${text:$i:1}"
		sleep ${delay}
	done
}
colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
	# background colors
	for bgc in {40..47}; do
		fgc=${fgc#37} # white
		bgc=${bgc#40} # black

		vals="${fgc:+$fgc;}${bgc}"
		vals=${vals%%;}

		seq0="${vals:+\e[${vals}m}"
		printf "  %-9s" "${seq0:-(default)}"
		printf " ${seq0}TEXT\e[m"
		printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
	done
	echo; echo
	done
}

wftp(){
	wget -m ftp://$1 -o $2 --ask-password
}
