// Client side C/C++ program to demonstrate Socket programming
#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#define PORT 8080
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>


	    


int main(int argc, char const *argv[])
{
	int sock = 0, valread;
	struct sockaddr_in serv_addr;
	char *hello = "Hello from client";
	char buffer[1024] = {0};

    usleep(500000);

	if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
	{
		printf("\n Socket creation error \n");
		return -1;
	}

	serv_addr.sin_family = AF_INET;
	serv_addr.sin_port = htons(PORT);

	// Convert IPv4 and IPv6 addresses from text to binary form
	if(inet_pton(AF_INET, "127.0.0.1", &serv_addr.sin_addr)<=0)
	{
		printf("\nInvalid address/ Address not supported \n");
		return -1;
	}

	if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
	{
		printf("\nConnection Failed \n");
		return -1;
	}
	const char* filename = "in";
    	while(1){
    		FILE *in_file = fopen(filename, "r");
    		if (!in_file) {
    			perror("fopen");
    			exit(EXIT_FAILURE);
    		}
    		struct stat sb;
    		if (stat(filename, &sb) == -1) {
    			perror("stat");
    			exit(EXIT_FAILURE);
    		}
    		char *contents = NULL;
    		size_t len = 0;
    		while (!feof(in_file)) {
    			if (getline(&contents, &len, in_file) != -1) {
    				printf("%s", contents);
				send(sock,contents,strlen(contents),0);
    			}
    		}
    		fclose(in_file);
    		exit(EXIT_SUCCESS);
    	}
}
