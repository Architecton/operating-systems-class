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
	int status = 0;
	int a = fork();

	if(a > 0)
	{
		if(fork())
		{
			waitpid(-1, &status, 0);
			printf("malo ");
			exit(WEXITSTATUS(status));
		}
		else
		{
			printf("se ");
			exit(1);
		}
	}
	else if(a != 0)
	{
		sleep(5
			);
		exit(1);
	}

	int f = open("izhod.txt", O_WRONLY);
	dup2(f, 1);

	for(int i = 0; i < a; i++)
	{
		if(fork())
		{
			write(2, "Kje ", 4);
			exit(10);
		}
		sleep(42);
		if(fork())
		{
			printf("sem ");
			exit(100);
		}
		else
		{
			printf("?");
			exit(101);
		}
		a = 1;
	}
	exit(42);
}