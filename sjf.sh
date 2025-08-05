#!/bin/bash
process=()

read -p "Enter the number of processes: " process_number
echo "Enter the process (process id, arrival time, burst time)"
for (( i=1 ; i<=process_number ; i++ )); do
    read -p "For process $i (pid at bt): " pid at bt
    process+=("$pid $at $bt")
done
remaining=("${process[@]}")

current_time=0
waiting_times=()
turnaround_times=()

while [[ ${#remaining[@]} -gt 0 ]]; do
    ready=()
    for proc in "${remaining[@]}"; do
        pid=$(awk '{print $1}' <<< "$proc")
        at=$(awk '{print $2}' <<< "$proc")
        bt=$(awk '{print $3}' <<< "$proc")

        if [[ "$at" -le "$current_time" ]]; then
            ready+=("$pid $at $bt")
        fi
    done

    if [[ ${#ready[@]} -eq 0 ]]; then
        (( current_time++ ))
        continue
    fi

    next_pro=$(printf "%s\n" "${ready[@]}" | sort -k3 -n | head -n1)
    pid=$(awk '{print $1}' <<< "$next_pro")
    at=$(awk '{print $2}' <<< "$next_pro")
    bt=$(awk '{print $3}' <<< "$next_pro")

    current_time=$(( current_time + bt ))
    tat=$(( current_time - at ))
    waiting=$(( tat - bt ))

    echo "$pid --> AT: $at -->BT: $bt --> CT:$current_time -->TAT: $tat --> WT: $waiting"
    
    waiting_times+=($waiting)
    turnaround_times+=($tat)

    temp=()
    for pros in "${remaining[@]}"; do
        if [[ $pros != "$pid "* ]]; then
            temp+=("$pros")
        fi
    done
    remaining=("${temp[@]}")
done

waiting_sum=0
tat_sum=0
for (( i=0; i<process_number ; i++ )); do
    waiting_sum=$(( waiting_sum + ${waiting_times[i]} ))
    tat_sum=$(( tat_sum + ${turnaround_times[i]} ))
done
echo "Average waiting time: $(echo "scale=2; $waiting_sum / $process_number" | bc)"
echo "Average turnaround time : $(echo "scale=2; $tat_sum / $process_number" | bc)" 