#!/bin/bash

# Parse number of processes to create. Default value is 100.
num_processes=${1:-100}

# Define empty array for storing pids of created processes.
pids=()


if ((num_processes == 1)); then
	printf "Ustvarjam ${num_processes} proces...\n"
elif ((num_processes == 2)); then
	printf "Ustvarjam ${num_processes} procesa...\n"
elif ((num_processes > 2 && num_processes < 5)); then
	printf "Ustvarjam ${num_processes} procese...\n"
else
	printf "Ustvarjam ${num_processes} procesov...\n"
fi


printf "PIDs: "

# Spawn xeyes process with approximately 2/3 probability or xclock with approximately 1/3 probability.
for (( i = 0; i < num_processes; i++ )); do

	if ((RANDOM <= 21845)); then
		xeyes &
	else
		xclock &
	fi

	printf "%d " "$!"
	# Store pid of spawned process in array
	pids=("${pids[@]}" "$!")
done
printf "\n"

if ((num_processes == 1)); then
	printf "Ukinjam proces...\n"
elif ((num_processes == 2)); then
	printf "Ukinjam procesa...\n"
else
	printf "Ukinjam procese...\n"
fi


printf "KILLs: "

# Go over array of pids of created processes in reverse and kill them.
for ((i=${#pids[@]} - 1; i >= 0; i--)) ; do
    kill "${pids[i]}"
    wait "${pids[i]}" 2>/dev/null
    printf "%d " "${pids[i]}"
done

printf "\n"