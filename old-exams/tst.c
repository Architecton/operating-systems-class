#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>

int main(void)
{
	execlp("test.sh", "test.sh", (char*)NULL);
	return 0;
}