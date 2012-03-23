#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <errno.h>
#include <unistd.h>
#include <sys/wait.h>

int global;

int main() {
	pid_t child_pid;
	int status;
	int local = 0;

	child_pid = fork();

	if(child_pid >= 0) {
		// child process
		if(child_pid == 0) {
			printf("child process.\n");
			local++;
			global++;

			printf("child pid = %d, parent pid = %d\n",getpid(),getppid());
			printf("child's local = %d, child's global = %d\n\n", local, global);

			char *cmd[] = {"whoami", (char*)0};
			return execv("/usr/bin/whoami", cmd);
		} else {
			printf("parent process.\n");
			printf("parent pid = %d, child pid = %d\n", getpid(), child_pid);

			wait(&status);

			printf("\nchild exit code: %d\n", WEXITSTATUS(status));
			printf("parent's local = %d, parent's global = %d\n", local, global);
			exit(0);
		}
	} else {
		perror("fork");
		exit(0);
	}
}
