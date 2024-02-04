#!/bin/bash
# Function to read specific lines from a file and save them to arrays
checkTypeChar(){
    if [[ "$1" =~ ^[a-zA-Z0-9_]+$ ]]; then
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
    echo -n "$value:" >> "$tableFile"
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
    echo $primaryKey &> /dev/null
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

# insertData
insertData() {
    tableName=$1
    DBName=$2
    metaFile="$HOME/maSQL/$DBName.db/meta/$tableName.meta"
    tableFile="$HOME/maSQL/$DBName.db/$tableName.table"
    # "columns" array
    columns_line=$(sed -n '3p' "$metaFile")
    IFS=":" read -ra columns <<< "$columns_line"

    # Read line number 4 and save it to the "types" array
    types_line=$(sed -n '4p' "$metaFile")
    IFS=":" read -ra types <<< "$types_line"

    #read Data in primary Key
    primaryKeyIndex=$(getPKIndex)
    primaryKeyIndex=$((primaryKeyIndex - 1)) #To adjust the index to the arr in
    
    #check the value of primary key 
    read -p "Please Enter The Value PK : " primaryKeyValue
    if isUniqueValue $primaryKeyValue; then
        echo "This Value is aready found in table."
        exit
    else 
        insertInFile $primaryKeyValue
    fi

    for ((i=0; i<${#columns[@]}; i++)); do
        if [ $i != $primaryKeyIndex ] ; then
            read -p "Enter the Value to insert in '${columns[i]}': " value #display colomn name to user
            if [[ ${types[i]} == "char" ]]; then # if type char
                if checkTypeChar $value ; then
                    insertInFile $value
                else
                    echo "this not data type of char ."
                    exit
                fi
            elif [[ ${types[i]} == "int" ]]; then # if type int
                if checkTypeInt $value ; then 
                    insertInFile $value
                else
                    echo "this not data type of int ."
                    exit 
                fi
            else
                echo "Unknown type for item '${columns[i]}'"
                exit
            fi
        fi
    done
}







