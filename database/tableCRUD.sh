#!/bin/bash
source ./functions/validation.sh
source ./functions/writeMetadata.sh
source ./database/recordsCRUD.sh
currentDB=""
printSubMenu() {
    
    echo "Choose an option from below:"
    echo "1) CREATE NEW Table"
    echo "2) UPDATE Table"
    echo "3) LIST AVAILABLE tables"
    echo "4) USE table"
    echo "5) DROP table"
    echo "6) Exit"
}
createTable() {
    local table_name=$1
    meta_file="./meta/$table_name.meta"
    table_file="./$table_name.table"
    
    if [ -e "$meta_file" ] || [ -e "$table_file" ]; then
        echo "Table '$table_name' already exists."
        return 1
    fi
    read -p "Please enter the number of columns: " columnsNumber
    if ! [[ $columnsNumber =~ ^[0-9]+$ ]]; then
        echo "Error: Not a number."
        return 1
    fi
    
    local columns=()
    local columnsTypes=()
    
    for ((i = 1; i <= columnsNumber; i++)); do
        read -p "Enter column name for column $i: " currentColumn
        columns+=("$currentColumn")
        
        # Validate column name
        if ! validate_name "$currentColumn"; then
            rm "$meta_file" "$table_file"
            echo "Please follow the name convention for columns. Exiting..."
            return 1
        fi
        validateColumnType $i
    done
    primaryKey=""
    read -p "Enter Primary key coloumn Number: " primaryKey
    if ! [[ $primaryKey =~ ^[0-9]+$ ]] || [ $primaryKey -le 0 ] || [ $primaryKey -ge $((columnsNumber+1)) ]; then
        echo "Error: Not a an integer or out of range."
        return 1
    fi
    touch "$meta_file" "$table_file"
    writeTableMetaData $primaryKey
    echo "Table '$table_name' created successfully with $columnsNumber columns and $primaryKey as primary key."
}

listTables() {
    echo "LIST SELECTED"
    table_list=$(ls -p | grep -v / | awk -F '.' '{print NR".", $1}')
    if [ -z "$table_list" ]; then
        echo "No tables found in $currentDB"
    else
        echo "$table_list"
    fi
}

useTable() {
    tableMenu $1 $2
}
dropTable() {
    local confirmation
    local tablePath="$HOME/maSQL/$currentDB.db/$1.table"
    if [ -f $tablePath ]; then
        read -p "This action is permenant ARE YOU SURE??? [y/n] " confirmation
        if [ $confirmation == "y" ] || [ $confirmation == "Y" ]; then
            rm  ./$1.table
            rm  ./meta/$1.meta
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
                read -p "Enter Table name: " tableName
                validate_name "$tableName"
                if [ $? -eq 1 ]; then
                    echo "Error: Invalid Table name."
                else
                    createTable $tableName
                fi
            ;;
            2)
                read dbName
                clear
                echo "$dbName"
                useDatabase $dbName
            ;;
            3)
                listTables
            ;;
            4)
                read -p "Enter Table name: " tableName
                useTable $tableName $currentDB
            ;;
            5)
                read -p "Enter Table name: " tableName
                validate_name "$tableName"
                if [ $? -eq 1 ]; then
                    echo "Error: Invalid Table name."
                else
                    useTable $tableName
                fi
            ;;
            6)
                clear
                echo "Returning to main menu..."
                break 1
            ;;
            *)
                echo "Invalid choice. Please enter a number from 1 to 4."
            ;;
        esac
    done
}