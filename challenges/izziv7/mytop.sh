# Set initial values.
disp_comm=1
disp_mem=1
disp_cpu=1
disp_user=1

# Loop.
while [ 1 ]
do
	clear
	# Compare user input
	if [ "$user_in" == 'q' ]; then
		exit 0
	fi
	if [[ "$user_in" == 'u' ]]; then
		if [[ "$disp_user" -eq '0' ]]; then
			disp_user=1
		else
			disp_user=0
		fi
	fi
	if [[ "$user_in" == 'c' ]]; then
		if [[ "$disp_comm" -eq '0' ]]; then
			disp_comm=1
		else
			disp_comm=0
		fi
	fi
	if [[ "$user_in" == 'm' ]]; then
		if [[ "$disp_mem" -eq '0' ]]; then
			disp_mem=1
		else
			disp_mem=0
		fi
	fi
	if [[ "$user_in" == 'p' ]]; then
		if [[ "$disp_cpu" -eq '0' ]]; then
			disp_cpu=1
		else
			disp_cpu=0
		fi
	fi
	if [ "$user_in" == 'h' ]; then
		echo "This script shows the 10 most cpu intensive processes that are currently running."
		echo "The displayed process properties can be toggled by pressing certain keys."
		echo "c - toggle command name display"
		echo "m - toggle memory usage display"
		echo "p - toggle cpu usage display"
		echo "u - toggle user display"
		echo "Press any key to continue."
		read
	fi
	
	# Hja... :/

	if [[ "$disp_comm" -eq '0' && "$disp_mem" -eq '0' && "$disp_cpu" -eq '0' && "$disp_user" -eq '0' ]]; then
		ps -eo pid --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '0' && "$disp_mem" -eq '0' && "$disp_cpu" -eq '0' && "$disp_user" -eq '1' ]]; then
		ps -eo pid,user --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '0' && "$disp_mem" -eq '0' && "$disp_cpu" -eq '1' && "$disp_user" -eq '0' ]]; then
		ps -eo pid,%cpu --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '0' && "$disp_mem" -eq '0' && "$disp_cpu" -eq '1' && "$disp_user" -eq '1' ]]; then
		ps -eo pid,user,%cpu --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '0' && "$disp_mem" -eq '1' && "$disp_cpu" -eq '0' && "$disp_user" -eq '0' ]]; then
		ps -eo pid,%mem --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '0' && "$disp_mem" -eq '1' && "$disp_cpu" -eq '0' && "$disp_user" -eq '1' ]]; then
		ps -eo pid,%mem,user --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '0' && "$disp_mem" -eq '1' && "$disp_cpu" -eq '1' && "$disp_user" -eq '0' ]]; then
		ps -eo pid,%mem,%cpu --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '0' && "$disp_mem" -eq '1' && "$disp_cpu" -eq '1' && "$disp_user" -eq '1' ]]; then
		ps -eo pid,%mem,user,%cpu --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '1' && "$disp_mem" -eq '0' && "$disp_cpu" -eq '0' && "$disp_user" -eq '0' ]]; then
		ps -eo pid,comm --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '1' && "$disp_mem" -eq '0' && "$disp_cpu" -eq '0' && "$disp_user" -eq '1' ]]; then
		ps -eo pid,comm,user --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '1' && "$disp_mem" -eq '0' && "$disp_cpu" -eq '1' && "$disp_user" -eq '0' ]]; then
		ps -eo pid,comm,%cpu --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '1' && "$disp_mem" -eq '0' && "$disp_cpu" -eq '1' && "$disp_user" -eq '1' ]]; then
		ps -eo pid,comm,user,%cpu --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '1' && "$disp_mem" -eq '1' && "$disp_cpu" -eq '0' && "$disp_user" -eq '0' ]]; then
		ps -eo pid,comm,%mem --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '1' && "$disp_mem" -eq '1' && "$disp_cpu" -eq '0' && "$disp_user" -eq '1' ]]; then
		ps -eo pid,comm,%mem,user --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '1' && "$disp_mem" -eq '1' && "$disp_cpu" -eq '1' && "$disp_user" -eq '0' ]]; then
		ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 11
	elif [[ "$disp_comm" -eq '1' && "$disp_mem" -eq '1' && "$disp_cpu" -eq '1' && "$disp_user" -eq '1' ]]; then
		ps -eo pid,comm,%mem,user,%cpu,%mem --sort=-%cpu | head -n 11
	fi
	
	read  -t 1 user_in
	
done