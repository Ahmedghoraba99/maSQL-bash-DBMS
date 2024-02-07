#!/bin/bash


selectData(){
    local tableName="$1"
    local DBName="$2"
    local tableFile="$HOME/maSQL/$DBName.db/$tableName.table"
    local metaFile="$HOME/maSQL/$DBName.db/meta/$tableName.meta"
    primaryKeyColumns=$(getPKIndex)
    read -p "Enter the Primary Key TO select : " searchData
    displayData $searchData $tableFile
}

displayData(){
    searchData=$1
    tableFile=$2
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
    
    result=$(grep "\<$searchData\>" "$tableFile" | awk -F':' '$'"$primaryKeyColumns"' == "'"$searchData"'" {print $0}' | awk -F':' -v max_length="$max_length-6" '
    BEGIN { printf "\n" }
    {
        for (i=1; i<NF; i++) {
            printf "%-" max_length "s |", $i
        }
        printf "\n"
    }
    END { printf "\n" }
    ')
    if [ -z "$result" ]; then
        echo -e "\e[91mThe Primary Key Value is not found....\e[0m"
    else
        echo "$result"
    fi
    
}



