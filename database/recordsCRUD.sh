#!/bin/bash
#BROKEN 
# source "../functions/insert.sh"
# source "../functions/update.sh"

printRecordsMenu() {
	echo "Choose an operation to perform on table $1"
	echo "1) CREATE NEW RECORD"
	echo "2) UPDATE EXISTING RECORD"
	echo "3) LIST ALL RECORDS"
	echo "4) DROP RECORD"
	echo "5) Exit"	
}

tableMenu() {
    while true; do
    printRecordsMenu
    read userInput
    case $userInput in
        1)
            read -p "Enter database name: " dbName
            validate_name "$dbName"
            if [ $? -eq 1 ]; then 
                echo "Error: Invalid database name."
            else
                createDatabase $dbName
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
            read dbName
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