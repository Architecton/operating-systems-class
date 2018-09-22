#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>

int main()
{
	int a, b, c = 0;
	a = fork();
	b = a;
	if(b == 0)
	{
		b = fork();
	}

	for(int i = 0; i < b; i++)
	{
		c = fork();
		if(a > 0)
		{
			exit(0);
		}
		exit(42);
	}
	exit(24);

	if(c == 0)
	{
		sleep(1);
		exit(123);
	}
}