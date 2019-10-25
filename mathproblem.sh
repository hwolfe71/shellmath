#!/bin/bash

# script which gives the user a choice of math problems to solve.

. ./mathlib

# check the passed parameter
# currently only displaying one or two digit problems

function usage() {
	echo "Usage: mathproblem.sh -asmd digits (1 or 2)"
	echo "    Display a math problem consisting of 1 or 2 digit numbers. When"
	echo "    digits is 1, both terms are single digit numbers. When digits is"
	echo "    2, one or both terms are two digit numbers, except for division."
	echo 

	echo "Options:"
	echo "    a    Display an addition problem."
	echo "    s    Display a subtraction problem. The smaller number will"
	echo "          always be subtracted from the larger."
	echo "    m    Display a multiplication problem."
	echo "    d    Display a division problem. The divisor and answer will"
	echo "          both be single digit numbers, however, the dividend more"
	echo "          than likely will be a 2 digit number."
	echo 
}

if [ $# -ne 2 ]; then
	usage
	exit 1
fi

digits=$2

if [[ "$digits" != "1" ]] && [[ "$digits" != "2" ]] ; then
	usage
	exit 1
fi

case $1 in
	-a|a) op="+"
		;;
	-s|s) op="-"
		;;
	-m|m) op="x"
		;;
	-d|d) op="/"
		digits=1
		;;
	*) usage
		exit 1
		;;
esac

again="y"

while [ "$again" = "y" ] || [ "$again" = "Y" ]
do
	clear

	case $op in
		+) 
			case $digits in
				1) x=`rand 9`
					y=`rand 9` ;;
				2) x=`rand 99`
					y=`rand 99` ;;
				*) printf "Error! Too many digits! This should not occur!\n"
					exit -1 ;;
			esac
			answer=`expr $x + $y` ;;
		-) 
			case $digits in
				1) x=`rand 9` ;;
				2) x=`rand 99` ;;
				*) printf "Error! Too many digits! This should not occur!\n"
					exit -1 ;;
			esac
			y=`randzero $x`
			answer=`expr $x - $y` ;;
		x) 
			case $digits in
				1) x=`rand 9`
					y=`randzero 9` ;;
				2) x=`rand 20`
					y=`randzero 20` ;;
				*) printf "Error! Too many digits! This should not occur!\n"
					exit -1 ;;
			esac
			answer=`expr $x \* $y` 
			;;
		/) 
			a=`rand 9`
			b=`rand 9`
			result=`expr $a \* $b`
			answer=$b
			x=$result
			y=$a
		   	;;
		*) 
			echo $op
			printf "Error! invalid operator!\n"
			exit -1 ;;
	esac

	solvemath "$x $op $y = " $answer

	read -p "Solve another problem? (y/n) " again
done

echo

