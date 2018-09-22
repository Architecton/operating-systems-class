#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <dirent.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>

// glavna funkcija
int main(int argc, char *argv[]) {

	DIR *dir_stream = NULL;
	// preveri pravilnost formata argumentov
	if(argc >= 3) {
		perror("unknown option %s\n", argv[2]);
		return 1;
	// ce ni podane poti - uporabi trenutni direktorij
	} else if(argc == 1) {
		char cwd[1024];
		char *dir = getcwd(cwd, sizeof(cwd));
		dir_stream = opendir(dir);	
	} else {
		// odpri podan direktorij (tok)
		dir_stream = opendir(argv[1]);
	}

	
	// ce je prislo do napake (dir_stream == NULL)
	if(dir_stream == NULL) {
		// preveri tip napake
		switch(errno) {
			case ENOENT:
				perror("The specified directory does not exist.\n");
				break;
			case ENOTDIR:
				perror("The specified name is not a directory.");
				break;
			case EACCES:
				perror("Acces denied.");
				break;
			default:
				perror("error");
		}
		// vrni se z ustreznim statusom
		return errno;
	}

	// definicija kazalca na strukturo dirent
	struct dirent *dir;

	// preber nasledjo stvar v toku direktorija
	dir = readdir(dir_stream);

	// dokler ne izcrpas toka direktorija
	while(dir != NULL) {
		// ne izpisuj . in ..
		if(strcmp(dir->d_name, ".") && strcmp(dir->d_name, "..")) {
			printf("%s  ", dir->d_name);
		}
		dir = readdir(dir_stream);
	}
	printf("\n");
	return 0;
}