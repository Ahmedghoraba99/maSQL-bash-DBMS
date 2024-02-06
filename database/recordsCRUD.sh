#!/bin/bash
source ./functions/insert.sh
source ./functions/readData.sh
source ./functions/delete.sh
source ./functions/update.sh
source ./functions/select.sh

printRecordsMenu() {
    echo "Choose an operation to perform on table $1"
    echo "1) CREATE NEW RECORD"
    echo "2) UPDATE EXISTING RECORD"
    echo "3) LIST ALL RECORDS"
    echo "4) DROP RECORD"
    echo "5) Select RECORD"
    echo "6) Exit"
}

tableMenu() {
    tableName=$1
    DBName=$2
    table="$HOME/maSQL/$DBName.db/$tableName.table"
    count=$(wc -l "$table" | awk '{print $1}')

    while true; do
        printRecordsMenu
        read -p "maSQL> " userInput
        case $userInput in
            1)
                insertData $tableName $DBName
            ;;
            2)
                if [ $count -ne 0 ]; then
                    update $tableName $DBName
                else
                    echo "The file is empty."
                fi
                
            ;;
            3)
                readData $tableName $DBName
            ;;
            4)
                if [ $count -ne 0 ]; then
                    delete $tableName $DBName
                else
                    echo "The file is empty."
                fi
            ;;
            5)
                selectData $tableName $DBName
            ;;
            6)
                echo "Byeeee..."
                break
            ;;
            *)
                echo "Invalid choice. Please enter a number from 1 to 4."
            ;;
        esac
    done
    
}




