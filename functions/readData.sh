#!/bin/bash

readData() {
    echo "started"
    local tableName="$1"
    local DBName="$2"
    local tableFile="$HOME/maSQL/$DBName.db/$tableName.table"
    
    # Calculate the length of the longest field
    max_length=$(awk '{
        for (i = 1; i <= NF; i++) {
            if (length($i) > max_length) {
                max_length = length($i);
            }
        }
    }
    END {
        print max_length;
    }' "$tableFile")
    
    echo "Length of the longest field in $tableName table: $max_length"
    
    # Print table data in a table-like format
    awk -F':' -v max_length="$max_length" '
    BEGIN { printf "\n" }
    {
        for (i=1; i<=NF; i++) {
            printf "%-" max_length "s |", $i
        }
        printf "\n"
    }
    END { printf "\n" }
    ' "$tableFile"
}

