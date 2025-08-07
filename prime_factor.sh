#!/bin/bash

prime_factor(){
    local -a seive
    local -a ans
    n=$1

    for (( i=2 ; i<=n+1 ; i++ )); do
        seive[i]=$i
    done

    for (( i=2; i<=n+1 ; i++ )); do
        if [[ ${seive[i]} -eq i ]]; then
            for (( j=i*i ; j<=n+1; j+=i ));do
                if [[ ${seive[j]} -eq j ]]; then
                    seive[j]=$i
                fi
            done
        fi
    done

    while (( n !=  1)); do
        ans+=(${seive[n]})
        (( n /= seive[n] ))
    done

    echo "${ans[@]}"
}

result=($(prime_factor $1))
echo "${result[@]}"