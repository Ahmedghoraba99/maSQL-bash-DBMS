#!/bin/bash

source "./insert.sh"

delete(){
    read -p "Enter the number of primary key to delete: " primaryKeyValue
    if isUniqueValue $primaryKeyValue ; then
        sed -i "/^${primaryKeyValue}:/d" "./file2.txt"

    else
        echo "the number is not found"
    fi

}

delete