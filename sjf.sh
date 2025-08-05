#!/bin/bash
process=("p1 0 5"
         "p2 1 3"
         "p3 2 8"
         "p4 3 6"
         )
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