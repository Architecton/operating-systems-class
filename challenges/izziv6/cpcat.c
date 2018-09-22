#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h> 
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>
#include <sys/file.h>

int main(int argc, char **argv)
{
	// parsing the arguments and opening streams accordingly //
	int read_in = -1;
	// open input stream
	if(argc == 1 || *argv[1] == '-') 
	{
		read_in = 0;	
	} 
	else 
	{
		read_in = open(argv[1], O_RDONLY);	
	}
	
	// check for errors
	if(read_in < 0)
	{
		perror("error");
		exit(errno);
	}

	// set input file lock to shared lock
	if(flock(read_in, LOCK_SH) < 0)
	{
		printf("error");
		exit(errno);
	}

	// open output stream
	int write_out = -1;
	if(argc < 3 || *argv[2] == '-') 
	{
		write_out = 1;
	} 
	else 
	{
		write_out = open(argv[2], O_WRONLY);	
	}
	

	// check for errors
	if(write_out < 0)
	{
		perror("error");
		exit(errno);
	}

	// set output file lock to exclusive lock
	if(flock(write_out, LOCK_EX) < 0)
	{
		printf("error");
		exit(errno);
	}

	// allocate memory for char byte buffer
	char buff[1];
	// read bytes
	while(read(read_in, &buff, 1) > 0) {
		write(write_out, &buff, 1);
	}

	// close input stream and check for errors
	if(close(read_in) < 0) 
	{
		printf("error");
		exit(errno);
	}

	// close output stream and check for errors
	if(close(write_out) < 0) 
	{
		printf("error");
		exit(errno);	
	}

	// return 0 if all went well
	return 0;
}