#!/bin/bash
source ./database/tableCRUD.sh
printMainMenu() {
    echo "Choose an option from below:"
    echo "1) CREATE NEW DATABASE"
    echo "2) USE EXISTING DATABASE"
    echo "3) LIST AVAILABLE DATABASES"
    echo "4) DROP DATABASE"
    echo "5) Exit"
}

createDatabase() {
    mkdir ~/maSQL/$1.db
    mkdir ~/maSQL/$1.db/meta
}

listDatabase() {
    echo "LIST SELECTED"
    ls ~/maSQL/$currentDB | awk -F '.' '{print NR".", $1}'
}

useDatabase() {
    if [ -d "$HOME/maSQL/$1.db" ]; then
        clear
        # TODO: Write submenu function which shows operations and send it as a parameter to the function containg the whil loop
        echo "USING DB $1"
        cd "$HOME/maSQL/$1.db"
        subMenu $1 #Calls the submenu from table crudtable file, giving it the db to work with
    else
        echo "Error: Database $1 not found."
    fi
}

dropDatabase() {
    
    local confirmation
    local databasePath="$HOME/maSQL/$1.db"
    if [ -d $databasePath ]; then
        echo "This action is permenant ARE YOU SURE??? [y/n] "
        read confirmation
        if [ $confirmation == "y" ] || [ $confirmation == "Y" ]; then
            rm -R $databasePath
        fi
    else
        echo "$1 dosen't exist"
        return
        
    fi
}
