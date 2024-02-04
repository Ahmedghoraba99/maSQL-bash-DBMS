#!/bin/bash
source ./functions/insert.sh
source ./functions/readData.sh
source ./functions/delete.sh

printRecordsMenu() {
    
    echo "Choose an operation to perform on table $1"
    echo "1) CREATE NEW RECORD"
    echo "2) UPDATE EXISTING RECORD"
    echo "3) LIST ALL RECORDS"
    echo "4) DROP RECORD"
    echo "5) Exit"
}

tableMenu() {
    tableName=$1
    DBName=$2
    while true; do
        printRecordsMenu
        read -p "maSQL> " userInput
        case $userInput in
            1)
                
                insertData $tableName $DBName
            ;;
            2)
                read dbName
                clear
                useDatabase $dbName
            ;;
            3)
                
                echo "11111111111"
                readData $tableName $DBName
                echo "222222222"
            ;;
            4)
                delete $tableName $DBName
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