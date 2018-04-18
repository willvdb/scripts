#!/bin/bash
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
wait(){
	text="$1"
	delay="$2"

	for i in $(seq 0 $(expr length "${text}")) ; do
		echo -ne "${text:$i:1}"
		sleep ${delay}
	done
}
echo -ne '\n\t'
wait 'Welcome to the Aperture Science Customer Care Program!' .01
sleep 1;echo
echo -e '\n\tInitializing Customer Care Engine....................'
for i in {1..100}; do sleep 0.01 && progress 100 0 $i;done
echo 'Complete!'
echo -e '\n\tExtracting Empathy Module............................'
for i in {1..100}; do sleep 0.001 && progress 100 0 $i;done
echo 'Complete!'
echo -e '\n\tCalibrating Humanity.................................'
for i in {1..100}; do sleep 0.007 && progress 100 0 $i;done
echo 'Complete!'
echo -e '\n\tEvaluating Attitude..................................'
for i in {1..100}; do sleep 0.007 && progress 100 0 $i;done
echo 'Complete!'
echo -e '\n\tImporting Scope of Support...........................'
for i in {1..100}; do sleep 0.002 && progress 100 0 $i;done
echo 'Complete!'
echo -e '\n\tCalculating Concern for Issue........................'
for i in {1..82}; do sleep 0.05 && progress 100 0 $i;done
echo ' Failed!!!'
echo -ne '\n\n\t[ERR]: Failed to give a damn!\n\t       Please contact your administrator or try again later.'
sleep 30
echo -ne '\n\t       '
wait '.....' .8
wait 'For real though, go fsck yourself.' .03
echo;sleep 10
