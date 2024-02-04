#!/bin/bash
# Validation function (used in coloumns/table names / DB names)
validate_name() {
    local name="$1"
    local nameIsValid=1
    
    # Check if the name length is between 3 and 20 characters
    if (( ${#name} < 3 || ${#name} > 20 )); then
        nameIsValid=0
    fi
    
    # Check if the first character is a letter (a-zA-Z)
    if [[ ! $name =~ ^[a-zA-Z] ]]; then
        nameIsValid=0
    fi
    
    # Check if the name contains only letters, numbers, and dots
    if [[ ! $name =~ ^[a-zA-Z][a-zA-Z0-9_.]*$ ]]; then
        nameIsValid=0
    fi
    
    # Check if there are no spaces in the name
    if [[ $name =~ \  ]]; then
        nameIsValid=0
    fi
    
    # Check if there are no special characters
    if [[ $name =~ [^a-zA-Z0-9_.] ]]; then
        nameIsValid=0
    fi
    
    # Return the value of name if all checks passed
    if [ $nameIsValid -eq 1 ]; then
        echo "$name" &> /dev/null
    else
        return 1
    fi
}
#this functoin that validates the types of daa for columns
#it takes two parameters, first is the coloumn number
validateColumnType() {
    while true; do
        read -p "Enter column type for column $i (int/char): " currentColumnType
        case $currentColumnType in
            int|char)
                columnsTypes[$i]="$currentColumnType"
                break
            ;;
            *)
                echo "Invalid column type. Please enter 'int' or 'char'."
            ;;
        esac
    done
    echo "$currentColumnType" &> /dev/null
}
