#!/bin/bash
source "./insert.sh"
delete(){
    local tableName="$1"
    local DBName="$2"
    local tableFile="$HOME/maSQL/$DBName.db/$tableName.table"
    local metaFile="$HOME/maSQL/$DBName.db/meta/$tableName.meta"
    read -p "Enter the number of primary key to delete: " primaryKeyValue
    local PKColoumn=$(head -2 $metaFile | tail -1)
    # Find the row number of the primary key value
    local searchRes=$(awk -F':' '$'"$PKColoumn"' == "'"$primaryKeyValue"'" {print NR}' aaa.table)
    echo " $searchRes is the row you want to delete"
    if [ -z "$searchRes" ]; then
        echo "No such record found."
    else
        # Delete the row
        sed -i "${searchRes}d" "$tableFile"
        echo "Record deleted successfully."
    fi
    
}
