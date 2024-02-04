#!/bin/bash
# Function to read specific lines from a file and save them to arrays
insertData() {
    tableName=$1
    DBName=$2
    metaFile="$HOME/maSQL/$DBName.db/meta/$tableName.meta"
    tableFile="$HOME/maSQL/$DBName.db/$tableName.table"
    # Read line number 3 and save it to the "columns" array
    columns_line=$(sed -n '3p' "$metaFile")
    IFS=":" read -ra columns <<< "$columns_line"

    # Read line number 4 and save it to the "types" array
    types_line=$(sed -n '4p' "$metaFile")
    IFS=":" read -ra types <<< "$types_line"

    #read Data in primary Key
    primaryKeyIndex=$(getPKIndex)
    primaryKeyIndex=$((primaryKeyIndex - 1))
    data=""

    for ((i=0; i<${#columns[@]}; i++)); do
        if [ $i == $primaryKeyIndex ] ; then
            read -p "Please Enter The Value PK Must Be Unique type is '${types[i]}': " primaryKeyValue
            if isUniqueValue $primaryKeyValue; then
                echo "This Value is aready found in table."
                return
            else 
                data="${data}$primaryKeyValue:"
            fi
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
    # echo $data
    insertInFile $data
    
}

checkTypeChar(){
    if [[ "$1" =~ ^[a-zA-Z0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

checkTypeInt(){
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

insertInFile() {
    local value="$1"
    echo -n "$value" >> "$tableFile"
}

getAllDataPK() {
    local file="$1"
    local pk_array=()

    # Read the file and extract primary keys
    while IFS=":" read -r pk rest; do
        # Check if the line contains a primary key
        if [[ -n $pk ]]; then
            pk_array+=("$pk")
        fi
    done < "$file"

    # Return the array
    echo "${pk_array[@]}"
}

getPKIndex(){
    primaryKey=$(sed -n '2p' "$metaFile")
    echo $primaryKey
}

isUniqueValue(){
    local PkArray=$(getAllDataPK "$tableFile")
    local value="$1"

    for element in $PkArray; do
        if [ $element == $value ] ; then
            return 0
        fi
    done

    return 1
}