#!/bin/bash

prime_factor(){
    local -a seive
    local -a ans
    number=$1
    n=$((number + 1))

    for (( i=2 ; i<=n ; i++ )); do
        seive[i]=$i
    done

    for (( i=2; i<=n ; i++ )); do
        if [[ ${seive[i]} -eq i ]]; then
            for (( j=i*i ; j<=n; j+=i ));do
                if [[ ${seive[j]} -eq j ]]; then
                    seive[j]=$i
                fi
            done
        fi
    done

    while (( number !=  1)); do
        ans+=("${seive[number]}")
        (( number /= seive[number] ))
    done

    echo "${ans[@]}"
}

result=($(prime_factor $1))
echo "${result[@]}"