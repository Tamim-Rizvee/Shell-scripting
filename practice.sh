#!/bin/bash
echo "Enter user name:"
read username
echo "Enter password"
read pass
if [[ $username="Tamim" && pass = 12 ]]; then echo "Hello"
else 
   echo "try again"
fi 

