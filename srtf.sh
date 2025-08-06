#!/bin/bash
read -p "Enter the process number: " process_number 
echo "Enter the processes(pid at bt)"
for (( i=1; i<=process_number ; i++ )); do
    read -p "for process $i : " pid at bt
    process+=("$pid $at $bt")
done

remaining=()
log=()
current_time=0
completed=0
declare -A completion_times 
declare -A waiting_times 
declare -A turnaround_times

for pros in "${process[@]}"; do
    read -r pid at bt <<< "$pros"

    remaining+=("$pid $at $bt $bt")
done

while [[ $completed -lt $process_number ]]; do
    ready=()
    for all in "${remaining[@]}" ; do
        at=$(awk '{print $2}' <<< "$all")
        if [[ "$at" -le "$current_time" ]]; then
            ready+=("$all")
        fi
    done

    if [[ ${#ready[@]} -eq 0 ]]; then
        (( current_time++ ))
        continue
    fi

    next_pros=$(printf "%s\n" "${ready[@]}" | sort -k4 -n | head -n1) 
    read -r pid at bt rt <<< "$next_pros"

    log+=("[$current_time]-->$pid")

    (( rt-- ))
    (( current_time++ )) 

    temp=()
    for all in "${remaining[@]}"; do
        if [[ $all == "$pid "* ]]; then
            if [[ $rt -eq 0 ]]; then
                completion_times["$pid"]=$current_time
                tat=$(( current_time - at ))
                waiting=$(( tat - bt ))
                waiting_times["$pid"]=$waiting
                turnaround_times["$pid"]=$tat
                (( completed++ ))
            else 
                temp+=("$pid $at $bt $rt")
            fi
        else 
            temp+=("$all")
        fi
    done

    remaining=("${temp[@]}")
done

echo "Execution Log:"
printf "%s\n" "${log[@]}"

echo
echo "PID  Arrival  Burst  Completion  Turnaround  Waiting"
waiting_sum=0
tat_sum=0
for pros in "${process[@]}"; do
    read -r pid at bt <<< "$pros"
    ct=${completion_times["$pid"]}
    tat=${turnaround_times["$pid"]}
    wt=${waiting_times["$pid"]}
    waiting_sum=$(( waiting_sum + wt ))
    tat_sum=$(( tat_sum + tat ))
    printf "%-4s %-8s %-6s %-11s %-11s %-7s\n" "$pid" "$at" "$bt" "$ct" "$tat" "$wt"
done

echo
echo "Average waiting time: $(echo "scale=2; $waiting_sum / $process_number" | bc)"
echo "Average turnaround time: $(echo "scale=2; $tat_sum / $process_number" | bc)"