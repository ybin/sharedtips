#include <stdio.h>
#include <signal.h>
#include <unistd.h>

// void (*signal(int signo, void (*handler)(int signo)))(int)

void handler(int signo) {
	if(signo == SIGKILL) {
		printf("received SIGKILL\n");
	} else if(signo == SIGSTOP) {
		printf("received SIGSTOP\n");
	} else if(signo == SIGINT) {
		printf("received SIGINT\n");
	}
}

void regist_signal() {
	if(signal(SIGKILL, handler) == SIG_ERR) {
		printf("cannot catch SIGKILL\n");
	} 
	if(signal(SIGSTOP, handler) == SIG_ERR) {
		printf("cannot catch SIGSTOP\n");
	}
	if(signal(SIGINT, handler) == SIG_ERR) {
		printf("cannot catch SIGINT\n");
	}
}

int main() {
	regist_signal();

	while(1)
		sleep(1);
	return 0;
}
