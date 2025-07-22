#!/bin/bash

read -p "Enter the arrival time process: " -a process
read -p "Enter the burst time of the process: " -a burst_time
n=${#process[@]}
for (( i=0 ; i<n-1; i++))
do 
    for (( j=0 ; j<n-i-1; j++))
    do
        if (( $(echo "${process[j]} > ${process[j+1]}" | bc) )); then
            temp=${process[j]}
            process[j]=${process[j+1]}
            process[j+1]=$temp

            temp=${burst_time[j]}
            burst_time[j]=${burst_time[j+1]}
            burst_time[j+1]=$temp
        fi
    done
done

# echo ${process[@]}
# echo
# echo ${burst_time[@]}

ct=0
declare -a c_time
declare -a tat_time
declare -a w_time
for (( i=0 ; i<n; i++));do
    c_time[i]=0
    tat_time[i]=0
    w_time[i]=0
done

for (( i=0 ; i<n ; i++)); do
    ct=$(( ct + burst_time[i] ))
    c_time[i]=$ct
done

for (( i=0 ; i<n ; i++)); do
   tat_time[i]=$(( c_time[i] - process[i]))
done

for (( i=0 ; i<n ; i++)); do
   w_time[i]=$(( tat_time[i] - burst_time[i]))
done

echo ${c_time[@]}
echo ${tat_time[@]}
echo ${w_time[@]}