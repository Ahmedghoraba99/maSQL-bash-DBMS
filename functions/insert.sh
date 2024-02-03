#!/bin/bash

# Function to read specific lines from a file and save them to arrays
insertData() {
    # Read line number 3 and save it to the "columns" array
    columns_line=$(sed -n '3p' "./file.txt")
    IFS=":" read -ra columns <<< "$columns_line"

    # Read line number 4 and save it to the "types" array
    types_line=$(sed -n '4p' "./file.txt")
    IFS=":" read -ra types <<< "$types_line"

    for ((i=0; i<${#columns[@]}; i++)); do
        read -p "Enter the Value to insert in '${columns[i]}': "
        if [[ ${types[i]} == "char" ]]; then # if type char
            echo "Item '${columns[i]}' is of type 'char'"

        elif [[ ${types[i]} == "int" ]]; then # if type int
            echo "Item '${columns[i]}' is of type 'int'"
        else
            echo "Unknown type for item '${columns[i]}'"
        fi
    done
}

# Call the function
insertData

# Display the content of the arrays
echo "Columns array: ${columns[@]}"
echo "Types array: ${types[@]}"
