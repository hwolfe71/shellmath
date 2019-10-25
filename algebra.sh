#!/bin/bash

# Script which gives the user the choice of solving for 1, 2 or 3 vars
# All variables and constants are between 1 and 9
# The equations are of the form
#	ax + b = c
#	ax + by = c; ax - by = d
#	ax + by + cz = d; ax + by - cz = e; ax - by + cz = f

# TODO:
# make 3 levels of difficulty for each number of variables
# 1 var:
#	easy: ax = b
#	med:  ax + b = c
#	hard: ax +/- b = c; x = 1-20
# 2 vars:
#	easy: ax + by = c, ax - by = c
#	med:  ax + by = c, ax - by = c; x, y = 1-20
#	hard: ax + by = c, dx + ey = f
# 3 vars:
#	easy: ax + by + cz = d, ax + by - cz = e, ax - by + cz = f
#	med:  ax + by + cz = d, ax + by - cz = e, ax - by + cz = f; x, y, z =
#	1-20
#	hard: ax + by + cz = d, ex + fy - gz = h, ix - jy + kz = l

. ./mathlib

MAX=9

function onevar {
	a=`rand $MAX`
	x=`rand $MAX`
	b=`rand $MAX`

	result=`expr $(($a * $x + $b))`

	printf "Solve for x in the following equation:\n"
	printf "%dx + %d = %d\n" "$a" "$b" "$result"
	
	solvealg "x" $x
}

function twovar {
	a=`rand $MAX`
	x=`rand $MAX`
	b=`rand $MAX`
	y=`rand $MAX`

	result=`expr $(($a * $x + $b * $y))`
	result2=`expr $(($a * $x - $b * $y))`

	printf "Solve for x and y in the following equations:\n"
	printf "%dx + %dy = %d\n" "$a" "$b" "$result"
	printf "%dx - %dy = %d\n" "$a" "$b" "$result2"

	solvealg "x" $x
	solvealg "y" $y
}

function threevar {
	a=`rand $MAX`
	x=`rand $MAX`
	b=`rand $MAX`
	y=`rand $MAX`
	c=`rand $MAX`
	z=`rand $MAX`

	result=`expr $(($a * $x + $b * $y + $c * $z))`
	result2=`expr $(($a * $x - $b * $y + $c * $z))`
	result3=`expr $(($a * $x + $b * $y - $c * $z))`

	printf "Solve for x, y, and z in the following equations:\n"
	printf "%dx + %dy + %dz= %d\n" "$a" "$b" "$c" "$result"
	printf "%dx - %dy + %dz= %d\n" "$a" "$b" "$c" "$result2"
	printf "%dx + %dy - %dz= %d\n" "$a" "$b" "$c" "$result3"

	solvealg "x" $x
	solvealg "y" $y
	solvealg "z" $z
}

again="y"

while [ "$again" = "y" ] || [ "$again" = "Y" ]
do
	clear

	# prompt user for number of variables

	numvars=0

	while [ $numvars -lt 1 ] || [ $numvars -gt 3 ]
	do
		read -p "Enter the number of variables to solve for (1-3): " numvars

		case $numvars in
			1) onevar 
				break ;;
			2) twovar
				break ;;
			3) threevar
				break ;;
			*) echo "Please enter a number between 1 and 3!"
				numvars=0
				continue ;;
		esac
	done

	read -p "Solve another set? (y/n) " again
done


