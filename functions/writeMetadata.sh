#!/bin/bash
# row one >> no of cols
# row two >> no of col of pk
# row three >> cols name
# row four >> types of cols
# data are seperated by :

writeTableMetaData() {
    echo $columnsNumber >> $meta_file
    echo $primaryKey >> $meta_file     #the number of the field of PK
    for column in "${columns[@]}"
        do
            echo -n "$column:" >> $meta_file
    done
    echo  >> $meta_file
    for columnsType in "${columnsTypes[@]}"
        do
            echo -n "$columnsType:" >> $meta_file
    done
}