#!/bin/bash
source "./insert.sh"
delete(){
    local tableName="$1"
    local DBName="$2"
    local tableFile="$HOME/maSQL/$DBName.db/$tableName.table"
    local metaFile="$HOME/maSQL/$DBName.db/meta/$tableName.meta"
    read -p "Enter the number of primary key to delete: " primaryKeyValue
    local PKColoumn=$(head -2 $metaFile | tail -1)
    # echo "pk in col $PKColoumn"
    local searchRes=$(awk -F':' -v column_number="$PKColoumn" -v search_value="$primaryKeyValue" '$column_number == search_value {print $column_number}' "$tableFile")
    echo $searchRes
    if isUniqueValue $primaryKeyValue ; then
        sed -i "/^${primaryKeyValue}:/d" "$tableFile"
        
    else
        echo "the number is not found"
    fi
    
}
