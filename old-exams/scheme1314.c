#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>

int main() {
	int f = dup(2);
	close(1);
	close(2);
	int a = fork();
	int b = fork();
	if (fork() == 0) {
		if (b > 0) exit(13);
		write(f, "Frihodnost\n", 3);
	}
	printf("%d\n", getpid());
	exit(7);
}