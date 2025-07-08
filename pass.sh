#!/bin/bash
echo "Enter your name:"
read name
if [[ $name = "Tamim" ]]; then
	echo "Hello $name"
else 
	echo "Enter right name"
fi
