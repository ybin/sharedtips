#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

int main() {
	FILE *fp = NULL;
	pid_t pid = 0;
	pid_t sid = 0;

	// create child process
	pid = fork();

	if(pid < 0) {
		printf("fork failed!\n");
		exit(1);
	}
	// parent process execute this. now parent process exit.
	if(pid > 0) {
		printf("pid of child process is %d\n", pid);
		exit(0);
	}
	// child process execute this.
	// unmask the file mode
	umask(0);
	// set new session
	sid = setsid();
	if(sid < 0) {
		exit(1);
	}
	// change the current working directory to root.
	chdir("/");
	// close stdin, stdout, stderr
	close(STDIN_FILENO);
	close(STDOUT_FILENO);
	close(STDERR_FILENO);

	// open a log file in write mode
	fp = fopen("log.txt", "w+");
	while(1) {
		sleep(10);
		fprintf(fp, "Logging info...\n");
		fflush(fp);
		// do some other thing for this deamon.
	}
	fclose(fp);
	return 0;
}
