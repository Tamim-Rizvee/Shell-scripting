#!/bin/bash
another=()
name=("tamim" "rizvee" "amader")
another+=($(printf "%s\n" "${name[@]}" | sort ))
echo "${another[@]}" 