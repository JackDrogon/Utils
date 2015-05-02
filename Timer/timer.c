#include "timer.h" // __TIMERT_H__

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <stdint.h>
#include <unistd.h>
#include <sys/time.h>

/*
 * TODO: use fd replacing FILE
 * TODO: use color output, check std* or console or file, referencing by yiyun
 * TODO: add stop, can use sharing variable(by formal params or global), memory, pipe, signal
 */

void* stimer(FILE *file, uint64_t sec)
{
	// FIXME: time's return_value is int, time_t time(time_t *) -> time_t = int
	// FIXME: remember setbuf origin value, setback when function is end
	setbuf(file, NULL);
	uint64_t begin = (uint64_t)time(NULL);
	uint64_t end = (uint64_t)time(NULL);
	while (end - begin <= sec) {
		fprintf(file, "%lld sec.\r", end - begin);
		usleep(200000);
		end = (uint64_t)time(NULL);
	}
	fprintf(stdout, "It's %lld seconds End!\n", sec);

	return NULL;
}

static inline uint64_t timeval_diff(struct timeval begin, struct timeval end)
{
	return (end.tv_sec - begin.tv_sec) * 1000000000 + (end.tv_usec - begin.tv_usec);
}

void* mtimer(FILE *file, uint64_t msec)
{
	// FIXME: remember setbuf origin value, setback when function is end
	setbuf(file, NULL);
	struct timeval begin, end;
	gettimeofday(&begin, NULL);
	gettimeofday(&end, NULL);
	while (timeval_diff(begin, end)/1000 <= msec) {
		fprintf(file, "%lld sec.\r", timeval_diff(begin, end)/1000);
		usleep(200);
		gettimeofday(&end, NULL);
	}
	fprintf(stdout, "It's %lld mseconds End!\n", msec);

	return NULL;
}
