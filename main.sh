#!/bin/bash
#maSQL
#main menu 

source ./database/dbCRUD.sh
source ./database/tableCRUD.sh
source ./functions/validation.sh

userInput=""
if [ ! -d ~/maSQL ]; then
	mkdir ~/maSQL
	echo "This is your first time using maSQL so welcome $USER !"
else
	echo "Welcome back $USER to maSQL! "
fi
echo "maSQL started succefully"
while true; do
    printMainMenu
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
