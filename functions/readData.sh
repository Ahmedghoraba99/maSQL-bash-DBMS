#!/bin/bash

readData() {
    echo "started"
    local tableName="$1"
    local DBName="$2"
    local tableFile="$HOME/maSQL/$DBName.db/$tableName.table"
    local metaFile="$HOME/maSQL/$DBName.db/meta/$tableName.meta"
    local columns=$(awk -F':' ' {print $n }' $metaFile)
    # Calculate the length of the longest field
    max_length=$(awk -F':' '{
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
    #print colNames
    
    # Print table header
    tail -2 $metaFile | head -1 |awk -F':' -v max_length="$((max_length ))" '{
        for (i=1; i<NF; i++) {
            printf "%-" max_length "s |", $i
        }
        printf "\n"
    }'
    
    # Print table data in a table-like format
    awk -F':' -v max_length="$max_length-6" '
    BEGIN { printf "\n" }
    {
        for (i=1; i<NF; i++) {
            printf "%-" max_length "s |", $i
        }
        printf "\n"
    }
    END { printf "\n" }
    ' "$tableFile"
}

