#include <signal.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <syslog.h>
#include <time.h>
#include <string.h>

// function prototypes
void signal_handler(int signum);

// static variables
static volatile int energy;
static volatile int print_dot;
static FILE *log_fd;
static struct tm *time_info;

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

	// Print id.
	printf("program pid = %d\n", getpid());

	// Fork child process
	pid_t pid = fork();

	// If error, signal.
	if (pid < 0)
	{
		exit(1);
	}

	// If sucess, exit parent process.
	if (pid > 0) 
	{
		exit(0);
	}

	// open log //
	log_fd = fopen("lovec.log", "a");
	//////////////

	// Define and initialize function for ackquiring time
	time_t raw_time;
	time (&raw_time);
	time_info = localtime(&raw_time);

	// set sid...
	pid_t sid = setsid();

	// If error...
	if (sid < 0) {
		exit(1);
	}

	close(STDIN_FILENO);
	close(STDOUT_FILENO);
	close(STDERR_FILENO);

	// main loop
	while(energy > 0)
	{
		fprintf(log_fd, (print_dot) ? ".\n" : "*\n");
		sleep(1);
		signal(SIGTERM, signal_handler);
		signal(SIGUSR1, signal_handler);
		signal(SIGUSR2, signal_handler);
		energy--;
	}

	// Get time string and remove trailing newline character.
	char *time = asctime(time_info);
	time[strlen(time) - 2] = '\0';
	fprintf(log_fd, "out of energy (%s)\n", time);
}

// signal_handler: handle signals caught in the main loop
void signal_handler(int signum)
{
	// Get time string and remove trailing newline character.
	char *time = asctime(time_info);
	time[strlen(time) - 2] = '\0';

	// if SIGTERM signal...
    if (signum == SIGTERM)
    {
        energy += 10;
		fprintf(log_fd, "Energy increased by 10. (%s)\n", time);
    }
    // if SIGUSR1 signal...
    else if (signum == SIGUSR1) {
		print_dot = (print_dot == 1) ? 0 : 1;    	
    }
    // if SIGUSR2 signal...
    else if (signum == SIGUSR2) {
    	// Fork child.
    	pid_t new_pid = fork();
		fprintf(log_fd, "Forked child with pid = %d\n (%s)\n", new_pid, time);

		// If in forked child...
		if(new_pid == 0) {
			sleep((energy % 7) + 1);
			int exit_status = 42*energy % 128;
			fprintf(log_fd, "Child exiting with status %d. (%s)\n", exit_status, time);
			exit(exit_status);
		}
    }
}