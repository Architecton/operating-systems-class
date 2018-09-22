#include <stdio.h>
#define MAX_SIZE 10000

int main(void){
	printf("test");
	char par[MAX_SIZE];
	FILE *file;
	file = fopen("/etc/passwd", "r");
	while(fgets(par, MAX_SIZE, file)){
		printf("%s", par);
	}
	return 0;
}
