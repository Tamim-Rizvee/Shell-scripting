#!/bin/bash

process=()

read -p "Enter the number of processes: " process_number
echo "Enter the process (process id, arrival time, burst time)"
for (( i=1 ; i<=process_number ; i++ )); do
    read -p "For process $i (pid at bt): " pid at bt
    process+=("$pid $at $bt")
done

remaining=()
current_time=0
quantum_time=2
entered=0
log=()
declare -A completion_times
declare -A waiting_times
declare -A turnaround_times
declare -A enter

for all in "${process[@]}"; do
    pid=$(awk '{print $1}' <<< "$all")
    enter["$pid"]=0
done

first_process=$(printf "%s\n" "${process[@]}" | sort -k2n | head -n1)
read -r pid at bt <<< "$first_process"
remaining+=("$pid $at $bt $bt")
enter["$pid"]=1
((entered++))

while [[ ${#remaining[@]} -gt 0 ]]; do
    next_proc="${remaining[0]}"
    remaining=("${remaining[@]:1}")
    read -r pid at bt rt <<< "$next_proc"

    log+=("[$current_time]-->$pid")

    if [[ $rt -ge $quantum_time ]]; then
        rt=$((rt - quantum_time))
        current_time=$((current_time + quantum_time))
    else
        current_time=$((current_time + rt))
        rt=0
    fi

    if [[ $entered -lt $process_number ]]; then
        for all in "${process[@]}"; do
            read -r npid nat nbt <<< "$all"
            if [[ "$nat" -le "$current_time" ]] && [[ ${enter["$npid"]} -eq 0 ]]; then
                remaining+=("$npid $nat $nbt $nbt")
                enter["$npid"]=1
                ((entered++))
            fi
        done
    fi

    if [[ $rt -eq 0 ]]; then
        tat=$((current_time - at))
        wt=$((tat - bt))
        completion_times["$pid"]=$current_time
        turnaround_times["$pid"]=$tat
        waiting_times["$pid"]=$wt
    else
        remaining+=("$pid $at $bt $rt")
    fi
done

echo "Execution Log:"
printf "%s\n" "${log[@]}"

echo
echo "PID  Arrival  Burst  Completion  Turnaround  Waiting"
waiting_sum=0
tat_sum=0

for all in "${process[@]}"; do
    read -r pid at bt <<< "$all"
    ct=${completion_times["$pid"]}
    tat=${turnaround_times["$pid"]}
    wt=${waiting_times["$pid"]}
    waiting_sum=$((waiting_sum + wt))
    tat_sum=$((tat_sum + tat))
    printf "%-4s %-8s %-6s %-11s %-11s %-7s\n" "$pid" "$at" "$bt" "$ct" "$tat" "$wt"
done

echo
echo "Average turnaround time: $(echo "scale=2; $tat_sum / $process_number" | bc)"
echo "Average waiting time: $(echo "scale=2; $waiting_sum / $process_number" | bc)"