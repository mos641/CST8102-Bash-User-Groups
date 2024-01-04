#!/bin/bash

# Lab 8
# CST8102
# userGroups.sh
# This script will provide a menu to add, edit and delete users/groups and execute the provided selections

# initialize the loop control variable
choice=t

# create a while loop to loop through until the user quits
while [ $choice != "Q" ] && [ $choice != "q" ]
do
	# clear the screen when the program starts and after every menu choice 
	clear

	#print the menu options
	echo -e "Choose one of the following options: \nA Create a user account \nB Delete a user account \nC Change supplementary group for a user account
D Change initial group for a user account \nE Change default login shell for a user account \nF Change account expiration date for a user account
Q to quit"
	
	#prompt for input and store in the choice variable
	read -p "What would you like to do?: " choice
	clear

	#if else structure to do what each choice indicates
	if [[ $choice = "a" ]] || [[ $choice = "A" ]]
	then
		#read input into variables, add a user and confirm its completed
		read -p "Enter the username: " username
		read -p "Enter the home directory as an absolute path: " directory
		read -p "Enter the default login shell as an absolute path: " loginShell
		useradd -d "$directory" -m -s "$loginshell" "$username"
		cat /etc/passwd | grep "$username"
		

	elif [[ $choice = "b" ]] || [[ $choice = "B" ]]
	then
		#read input into variables and delete indicated user, confirm its completed
		read -p "Enter the username of the user to be deleted: " username
		userdel -r "$username"
		

	elif [[ $choice = "c" ]] || [[ $choice = "C" ]]
	then
		#read input into variables, add indicated suplemental group to user and confirm its completed
		read -p "Enter the username to be added to a group: " username
		read -p "Enter the supplemental group name: " group
		usermod -G "$group" "$username"
		groups "$username"
		

	elif [[ $choice = "d" ]] || [[ $choice = "D" ]]
	then
		#read input into variables, change indicated initial group of user and confirm its completed
		read -p "Enter the username to change the initial group: " username
		read -p "Enter the initial group name: " group
		usermod -g "$group" "$username"
		groups "$username"
		

	elif [[ $choice = "e" ]] || [[ $choice = "E" ]]
	then
		#read input into variables, change the indicated shell of the user and confirm its completed
		read -p "Enter the username for the change of shell: " username
		read -p "Enter the shell name: " shell
		chsh -s "$shell" "$username"
		cat /etc/passwd | grep $username
		
	elif [[ $choice = "f" ]] || [[ $choice = "F" ]]
	then
		#read input into variables, change the indicated users expiry date and confirm it is completed
		read -p "Enter the username to change the expiry date of: " username
		read -p "Enter the new expiry date in YYYY-MM-DD format: " expiry
		usermod -e "$expiry" "$username"
		chage -l "$username" | grep "Account expires"

	elif [[ $choice = "q" ]] || [[ $choice = "Q" ]]
	then
		#if they quit tell them they are
		echo Quitting...
	else
		#if it is not any of the listed options, print an error message
		echo Invalid input, try again. Select one of the listed options.
	fi

	#sleep for 3 seconds and clear
	sleep 3
	clear


done
