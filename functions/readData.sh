#!/bin/bash

readData() {
    echo "started"
    local tableName="$1"
    local DBName="$2"
    local tableFile="$HOME/maSQL/$DBName.db/$tableName.table"
    
    awk -F':' '
        BEGIN { printf "\n" }
        {
            printf "%-5s", $1
            for (i=2; i<=NF; i++) {
                printf "%-15s", $i
            }
            printf "\n"
        }
        END { printf "\n" }
    ' "$tableFile"
}


