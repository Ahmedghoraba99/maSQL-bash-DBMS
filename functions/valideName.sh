#! /bin/bash

######### function in project  ##########

validate_name() {
    local name="$1"
    
    # Check if the name length is between 3 and 20 characters
    if (( ${#name} < 3 || ${#name} > 20 )); then
        echo 1
        return
    fi

    # Check if the first character is a letter (a-zA-Z)
    if [[ ! $name =~ ^[a-zA-Z] ]]; then
        echo 1
        return
    fi

    # Check if the name contains only letters, numbers, and dots
    if [[ ! $name =~ ^[a-zA-Z][a-zA-Z0-9_.]*$ ]]; then
        echo 1
        return
    fi

    # Check if there are no spaces in the name
    if [[ $name =~ \  ]]; then
        echo 1
	return 
    fi

    # Check if there are no special characters
    if [[ $name =~ [^a-zA-Z0-9_.] ]]; then
        echo 1
	return 
    fi
    	
    echo $name
}

read -p "Enter name: " name

if [[ $(validate_name "$name") -eq 1 ]]; then
    echo "Name IS Not Valid"
else
    echo "Name is valid."
fi
