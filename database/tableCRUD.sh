#!/bin/bash
source ./functions/validation.sh

printSubMenu() {
	echo "Choose an option from below:"
	echo "1) CREATE NEW Table"
	echo "2) UPDATE Table"
	echo "3) LIST AVAILABLE tables"
	echo "4) DROP table"
	echo "5) Exit"
}
createTable() {
	touch ./$1.db
    read -p "Please enter the number of coloumns" columnsNumber
    local columns=()
    local columnsTypes=()
    for ((i=1 ; i<= $columnsNumber; i+=1 )); do
        read -p "Enter column name for column $i" currentColumn
        columns+=("$currentColumn")
        local validationResult=validate_name $currentColumn
        if [ validationResult -eq 1 ]; then
            rm ./$1.table
            echo "Please follow the name convintion, exiting....."
            return 1
        fi
        read -p "Enter column name for column $i" currentColumnType
        columnsTypes+=("$currentColumnType")
    done
    #call something 
}
listDatabase() {
	echo "LIST SELECTED"
	ls ~/maSQL | awk -F '.' '{print NR".", $1}'
}
useDatabase() {
	if [ -d "$HOME/maSQL/$1.db/$2" ]; then
		clear
		# TODO: Write submenu function which shows operations
		echo "USING DB $1"
		cd "$HOME/maSQL/$1.db" || return 1
	else
		echo "Error: Database $1 not found."
	fi
}
dropTable() {
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

subMenu(){
    currentDB=$1
while true; do
    printSubMenu
    read userInput
    case $userInput in
        1)
            read -p "Enter database name: " dbName
            validate_name "$dbName"
            if [ $? -eq 1 ]; then 
                echo "Error: Invalid database name."
            else
                createTable $dbName
            fi 
            ;;
        2)
            read dbName
            clear
            useDatabase $dbName
            ;;
        3)
            listDatabase 
            ;;
        4)
            ead -p "Enter database name: " dbName
            validate_name "$dbName"
            if [ $? -eq 1 ]; then 
                echo "Error: Invalid database name."
            else
                dropDatabase $dbName
            fi 
            ;;
        5)
            echo "Byeeee..."
            break
            ;;
        *)
            echo "Invalid choice. Please enter a number from 1 to 4."
            ;;
    esac
done
}