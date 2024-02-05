#!/bin/bash

# source "./insert.sh"


update(){
    read -p "print the value of primary key to update: " primaryKeyValue
    local tableName="$1"
    local DBName="$2"
    local tableFile="$HOME/maSQL/$DBName.db/$tableName.table"
    local metaFile="$HOME/maSQL/$DBName.db/meta/$tableName.meta"

    columns_line=$(sed -n '3p' "$metaFile")
    IFS=":" read -ra columns <<< "$columns_line"

    types_line=$(sed -n '4p' "$metaFile")
    IFS=":" read -ra types <<< "$types_line"

    numberOfColumns=$(head -n 1 "$metaFile")
    # echo "nuber of coulums: "$numberOfColumns
    primaryKeyColumns=$(getPKIndex)
    # echo "number of coulumns PK is : "$primaryKeyColumns
    primaryKeyIndex=$((primaryKeyColumns - 1))
    # echo "index of PK is : "$primaryKeyIndex

    data=$(cat "$tableFile")
    AllValueOfPK=()
    AllValueOfPK=( $(echo "$data" |  awk -F ':' "{for(i=${primaryKeyColumns};i<=NF;i+=${numberOfColumns}) print \$i}") )

    if checkValueExist "${AllValueOfPK[*]}" $primaryKeyValue; then
        #calling for insert update row
        getValueForUpdate $columns $types $primaryKeyIndex
    else 
        echo "This Value is not found in table."
        return
    fi
}


checkValueExist(){
    local AllValueOfPK=$1
    local value=$2

    for element in $AllValueOfPK; do
        if [ $element == $value ] ; then
            return 0
        fi
    done

    return 1
}

getValueForUpdate(){
    columns=$1
    types=$2
    primaryKeyIndex=$3
    data=""

    for ((i=0; i<${#columns[@]}; i++)); do
        if [ $i == $primaryKeyIndex ] ; then
            data="${data}$primaryKeyValue:"
            
        else 
            read -p "Enter the Value to insert in '${columns[i]}' '${types[i]}' : " value
            if [[ ${types[i]} == "char" ]]; then # if type char
                if checkTypeChar $value ; then
                    data="${data}$value:"
                else
                    echo "this not data type of char ."
                    return
                fi
            elif [[ ${types[i]} == "int" ]]; then # if type int
                if checkTypeInt $value ; then 
                    data="${data}$value:"
                else
                    echo "this not data type of int ."
                    return 
                fi
            else
                echo "Unknown type for item '${columns[i]}'"
                return
            fi
        fi
    done
    updateData $primaryKeyValue $data
}


updateData(){
    local tableFile="$HOME/maSQL/$DBName.db/$tableName.table"
    local searchData=$1
    local data=$2

    if grep -q "\<$searchData\>" "$tableFile"; then
        sed -i "/\<$searchData\>/s/.*/${data}/" "$tableFile"
        echo "Row containing '$searchData' replaced with '$data'."
    else
        echo "Value '$searchData' not found in the file."
        return
    fi
}