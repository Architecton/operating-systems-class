#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>

int main()
{
	pid_t pid_1, pid_2;
	int fd[2];

	// Create a pipe
	pipe(fd);

	// Fork first part of pipeline
	pid_1 = fork();

	// If in child...
	if(pid_1 == 0)
	{
		// Redirect stdout to pipe write side.
		dup2(fd[1], STDOUT_FILENO);

		// Close file descriptors.
		close(fd[0]);
		close(fd[1]);

		// Execute system call.
		execlp("ls", "ls", (char*)NULL);
	}
	else
	{

		// Fork second part of pipeline (writes to stdout).
		pid_2 = fork();

		// If in child...
		if(pid_2 == 0)
		{	
			dup2(fd[0], 0);

			// Close file descriptors
			close(fd[0]);
			close(fd[1]);

			// Redirect stdout to file.
			int file_fd = open("f.txt", O_CREAT | O_WRONLY, 777);
			dup2(file_fd, STDOUT_FILENO);

			// Execute system call.
			execlp("grep", "grep", "o", (char*)NULL);
		}
		else
		{
			// Close file descriptors.
			close(fd[0]);
			close(fd[1]);

			// Wait for children to finish.
			int status;
			waitpid(pid_1, &status, 0);
			waitpid(pid_2, &status, 0);

			return 0;
		}
	}
}
