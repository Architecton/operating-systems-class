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

	// Fork first part of pipeline.
	pid_1 = fork();

	// If in child
	if(pid_1 == 0)
	{
		// Redirect stdout to write side of pipe
		dup2(fd[1], STDOUT_FILENO);

		// Close file descriptors
		close(fd[0]);
		close(fd[1]);

		// Redirect stderr to file
		int file_fd = open("f.err", O_WRONLY | O_CREAT, 0777);
		dup2(file_fd, STDERR_FILENO);

		// Execute system call.
		execlp("cat", "cat", "f.txt", (char*)NULL);
	}
	else
	{
		// Fork second part of pipeline (prints to stdout)
		pid_2 = fork();

		// If in child.
		if(pid_2 == 0)
		{
			// Redirect read part of pipe to stdin.
			dup2(fd[0], 0);

			// Close file descriptors.
			close(fd[0]);
			close(fd[1]);

			// Redirect stdout to file (APPEND)
			int file_fd = open("b.txt", O_WRONLY | O_APPEND | O_CREAT, 0777);
			dup2(file_fd, STDOUT_FILENO);

			// Execute system call
			execlp("wc", "wc", "-l", (char*)NULL);

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

			// Execute system call.
			execlp("cat", "cat", "b.txt", (char*)NULL);

			return 0;
		}
	}
}