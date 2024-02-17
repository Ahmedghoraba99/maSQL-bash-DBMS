#!/bin/bash
source ./functions/insert.sh
source ./functions/readData.sh
source ./functions/delete.sh
source ./functions/update.sh
source ./functions/select.sh
source ./functions/selectByColumns.sh

printRecordsMenu() {
    echo "Choose an operation to perform on table $1"
    echo "1) CREATE NEW RECORD"
    echo "2) UPDATE EXISTING RECORD"
    echo "3) LIST ALL RECORDS"
    echo "4) DROP RECORD"
    echo "5) Select RECORD by PK"
    echo "6) Select RECORD by columns"
    echo "7) Exit"
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
                update $tableName $DBName
            ;;
            3)
                readData $tableName $DBName
            ;;
            4)
                delete $tableName $DBName

            ;;
            5)
                selectData $tableName $DBName
            ;;
            6)
                #if [ $count -ne 0 ]; then
                selectByColumns $tableName $DBName
                #else
                #    echo "The file is empty."
                #fi
            ;;
            7)
                echo "Byeeee..."
                break
            ;;
            *)
                echo "Invalid choice. Please enter a number from 1 to 4."
            ;;
        esac
    done
    
}




