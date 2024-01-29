#!/bin/bash
#maSQL
#main menu 
#
source ./database/dbCRUD.sh
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
            read dbName
            createDatabase "$dbName" 
            ;;
        2)
            read dbName
            clear
            echo "aaaaaaaaa"
            useDatabase dbName
            ;;
        3)
            listDatabase dbName
            ;;
        4)
            read dbName
            dropDatabase "$dbName"
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
