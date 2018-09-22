#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>

int main(void)
{
	pid_t pid_1, pid_2;
	int fd[2];

	// Make pipe.
	pipe(fd);

	// Fork first part of pipeline.
	pid_1 = fork();

	// If in child...
	if(pid_1 == 0)
	{
		// Redirect stout to write end of pipe.
		dup2(fd[1], STDOUT_FILENO);

		// Close file descriptors.
		close(fd[0]);
		close(fd[1]);

		// Assume no error.
		int return_val = 0;

		// Execute system call.
		return_val = execlp("cat", "cat", "tocke", (char*)NULL);

		// Exit child.
		exit(return_val);
	}
	else
	{
		// Fork second part of pipeline
		pid_2 = fork();

		// If in child...
		if(pid_2 == 0)
		{
			// Redirect read part of pipe to stdin.
			dup2(fd[0], 0);

			// Close file descriptors
			close(fd[0]);
			close(fd[1]);

			// Redirect stderr to file "log"
			int file_fd = open("log", O_CREAT | O_WRONLY, 0777);
			dup2(file_fd, STDERR_FILENO);

			// Assume no error.
			int return_val = 0;

			// Execute system call.
			return_val = execlp("izracun_ocene.sh", "izracun_ocene.sh", (char*)NULL);

			// Exit child.
			exit(return_val);

		}
		else
		{
			// Close file descriptors
			int status_1, status_2;

			// Wait for children to finish.
			waitpid(pid_1, &status_1, 0);
			waitpid(pid_2, &status_2, 0);

			// If there was an error in the pipeline...
			if(status1 != 0 || status2 != 0);
			{
				// Fork new process.
				int pid_3 = fork();

				// If in child...
				if(pid_3 == 0)
				{
					// Make directory
					mkdir("FAIL", 0777);
				}
				else
				{
					// Wait for child to finish
					wait(NULL);
				}
			}
			return 0;
		}
	}
}
