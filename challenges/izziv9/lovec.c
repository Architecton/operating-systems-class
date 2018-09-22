#include <signal.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

// function prototypes
void signal_handler(int signum);

// static variables
static volatile int energy;
static volatile int print_dot;

// main function
int main(int argc, char **argv)
{
	if(argc > 1) {
		// Parse specified energy.
		energy = atoi(argv[1]);
	} else {
		energy = 42;
	}
	// Print dots initially.
	print_dot = 1;
	printf("program pid = %d\n", getpid());

	// main loop
	while(energy > 0)
	{
		printf((print_dot) ? ".\n" : "*\n");
		sleep(1);
		signal(SIGTERM, signal_handler);
		signal(SIGUSR1, signal_handler);
		signal(SIGUSR2, signal_handler);
		energy--;
	}
	printf("out of energy\n");
}

// signal_handler: handle signals caught in the main loop
void signal_handler(int signum)
{
    if (signum == SIGTERM)
    {
        energy += 10;
		printf("Energy increased by 10.");
    }
    else if (signum == SIGUSR1) {
		print_dot = (print_dot == 1) ? 0 : 1;    	
    }
    else if (signum == SIGUSR1) {
    	pid_t new_pid = fork();
		printf("Forked child with pid = %d\n", new_pid);

		if(new_pid == 0) {
			sleep((energy % 7) + 1);
			int exit_status = 42*energy % 128;
			printf("Child exiting with status %d", exit_status);
			exit(exit_status);
		}
    }
}