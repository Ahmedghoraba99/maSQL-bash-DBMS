#!/bin/bash

selectByColumns(){
    local tableName="$1"
    local DBName="$2"
    local tableFile="$HOME/maSQL/$DBName.db/$tableName.table"
    local metaFile="$HOME/maSQL/$DBName.db/meta/$tableName.meta"
    local found=false
    local colIndex=0
    ###################################
    columns_line=$(sed -n '3p' "$metaFile")
    IFS=":" read -ra columns <<< "$columns_line"

    ############### Read colum name #####################
    read -p "Enter the columns name (${columns[*]}): " colNameValue
    colNameValue=$(echo "$colNameValue" | tr '[:upper:]' '[:lower:]')

    for ((i=0; i<${#columns[@]}; i++)); do
        if [ "${columns[i]}" = "$colNameValue" ]; then
            colIndex=$((i+1))
            found=true
        fi
    done

    if [ "$found" = true ]; then
        numberOfColumns=$(head -n 1 "$metaFile")
        data=$(cat "$tableFile")
        echo -e "$data" |  awk -F ':' "{for(i=${colIndex};i<=NF;i+=${numberOfColumns}) print \$i}"
    else
        echo -e "\e[91mThe '$colNameValue' colums is not found....\e[0m"
        # echo -e "\e[32mThe '$colNameValue' column is not found....\e[0m"
    fi
}





