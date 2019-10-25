#!/bin/bash

. ./mathlib

again="y"

while [ "$again" = "y" ] || [ "$again" = "Y" ]
do
	clear
	MAX=100
	guess=-1
	answer=`rand $MAX`
	ceiling=$MAX
	floor=1
	guesses=0

	while [ "$guess" -ne "$answer" ]
	do
		let guesses+=1
		echo "The magic number is between $floor and $ceiling."
		read -p " Guess #$guesses: " guess

		# if guess isn't a number, continue

		cleanguess=`echo $guess | tr -d [:digit:]`
		if [[ $guess == "" ]] || [[ "$cleanguess" != "" ]] ; then
			printf "Please enter a number!\n\n"
			guess=-1
			continue 
		fi

		if [ "$guess" -lt "$answer" ]; then
			echo "$guess is too low"
			if [ "$guess" -ge "$floor" ]; then
				let floor=$guess+1
			fi
		fi
		if [ "$guess" -gt "$answer" ]; then
			echo "$guess is too high"
			if [ "$guess" -le "$ceiling" ]; then
				let ceiling=$guess-1
			fi
		fi
	done

	echo "You got it in $guesses guesses!"

	read -n 1 -p "Guess again? (y/n) " -s again
	echo
done

