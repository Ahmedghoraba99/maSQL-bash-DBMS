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
    grep "\<$searchData\>" "$tableFile" | awk -F':' '$'"$primaryKeyColumns"' == "'"$searchData"'" {print $0}' 

}



