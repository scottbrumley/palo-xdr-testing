#!/bin/bash

echo "T1158 - Hidden Files and Directories"

echo "Atomic Test #1 - Create a hidden file in a hidden directory"
mkdir /var/tmp/.hidden-directory
echo "T1158" > /var/tmp/.hidden-directory/.hidden-file

echo "Clean Up Test #1"
rm -rf /var/tmp/.hidden-directory/


