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
log=()

declare -A completion_times 
declare -A waiting_times 
declare -A turnaround_times



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

    log+=("[$current_time]-->$pid")

    current_time=$(( current_time + bt ))
    tat=$(( current_time - at ))
    waiting=$(( tat - bt ))
    
    waiting_times["$pid"]=$waiting
    turnaround_times["$pid"]=$tat
    completion_times["$pid"]=$current_time

    temp=()
    for pros in "${remaining[@]}"; do
        if [[ $pros != "$pid "* ]]; then
            temp+=("$pros")
        fi
    done
    remaining=("${temp[@]}")
done

echo 
echo "Execution log: "
printf "%s\n" "${log[@]}"
echo

echo "PID  Arrival  Burst  Completion  Turnaround  Waiting"

waiting_sum=0
tat_sum=0
for pros in "${process[@]}"; do
    pid=$(awk '{print $1}' <<< "$pros")
    at=$(awk '{print $2}' <<< "$pros")
    bt=$(awk '{print $3}' <<< "$pros")
    ct=${completion_times["$pid"]}
    tat=${turnaround_times["$pid"]}
    wt=${waiting_times["$pid"]}
    waiting_sum=$(( waiting_sum + wt ))
    tat_sum=$(( tat_sum + tat ))
    printf "%-4s %-8s %-6s %-11s %-11s %-7s\n" "$pid" "$at" "$bt" "$ct" "$tat" "$wt"
done
echo
echo "Average waiting time: $(echo "scale=2; $waiting_sum / $process_number" | bc)"
echo "Average turnaround time : $(echo "scale=2; $tat_sum / $process_number" | bc)" 