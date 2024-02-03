#!/bin/bash

displayData() {
    local file="$1"

    awk -F':' '
        BEGIN { printf "\n" }
        {
            printf "%-5s", $1
            for (i=2; i<=NF; i++) {
                printf "%-15s", $i
            }
            printf "\n"
        }
        END { printf "\n" }
    ' "$file"
}


displayData "./file2.txt"
