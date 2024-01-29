#!/bin/bash
printMainMenu() {
	echo "Choose an option from below:"
	echo "1) CREATE NEW DATABASE"
	echo "2) USE EXISTING DATABASE"
	echo "3) LIST AVAILABLE DATABASES"
	echo "4) DROP DATABASE"
	echo "5) Exit"	
}

createDatabase() {
	mkdir ~/maSQL/$1.db
}
listDatabase() {
	echo "LIST SELECTED"
	ls ~/maSQL | awk -F '.' '{print NR".", $1}'
}
useDatabase() {
	echo "USE SELECTED"
	cd ~/maSQL/$1.db
}
dropDatabase() {
	
	local confirmation
	local databasePath="$HOME/maSQL/$1.db"
	if [ -d $databasePath ]; then 
		echo "This action is permenant ARE YOU SURE??? [y/n] "
		read confirmation
		if [ $confirmation == "y" ] || [ $confirmation == "Y" ]; then
			rm -R $databasePath
		fi
	else
		echo "$1 dosen't exist"
		return 
	
	fi
}
