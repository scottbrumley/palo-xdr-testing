#!/bin/bash

echo "T1156 - .bash_profile and .bashrc"

echo "Making Bad Python Program"
touch /tmp/T1156.py
echo "print('Hello, world!')" > /tmp/T1156.py

echo "Atomic Test #1 - Add command to .bash_profile"
echo "/tmp/T1156.py" >> ~/.bash_profile

echo "Atomic Test #2 - Add command to .bashrc"
echo "/tmp/T1156.py" >> ~/.bash_rc

