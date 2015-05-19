#include <stdlib.h>
#include <unistd.h>

#include "io.h"

// typedef int bool;

int read_n(int fd, char *buf, size_t len)
{
	size_t i, got = 0;
	do {
		if ((i = read(fd, buf+got, len-got)) <= 0) {
			return got;
		}
		got += i;
	} while (got < len);

	return len;
}
