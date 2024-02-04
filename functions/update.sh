#!/bin/bash

source "./insert.sh"


update(){
    read -p "print the value of primary key to update: " primaryKeyValue
    if isUniqueValue $primaryKeyValue ; then
        columns_line=$(sed -n '3p' "./file.txt")
        IFS=":" read -ra columns <<< "$columns_line"
        
        types_line=$(sed -n '4p' "./file.txt")
        IFS=":" read -ra types <<< "$types_line"

        primaryKeyIndex=$(getPKIndex)
        primaryKeyIndex=$((primaryKeyIndex - 1))
        newData="$primaryKeyValue:"

        for ((i=0; i<${#columns[@]}; i++)); do
            if [ $i != $primaryKeyIndex ] ; then
                read -p "Enter the Value to insert in '${columns[i]}': " value
                if [[ ${types[i]} == "char" ]]; then # if type char
                    if checkTypeChar $value ; then
                        newData=${newData}"$value:"
                    else
                        echo "this not data type of char ."
                        exit
                    fi
                elif [[ ${types[i]} == "int" ]]; then # if type int
                    if checkTypeInt $value ; then 
                        newData=${newData}"$value:"
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
        #sed -i "/^${primaryKeyValue}c\\$newData" "./file2.txt"
        sed -i "/^${primaryKeyValue}/s/.*/$newData/" "./file2.txt"
        
    else 
        echo "value is not found in table "
        exit
    fi
}

update