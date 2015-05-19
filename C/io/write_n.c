#include <stdlib.h>
#include <unistd.h>

#include "io.h"

// typedef int bool;

int write_n(int fd, char *buf, size_t len)
{
	size_t i, wrote = 0;
	do {
		if ((i = write(fd, buf+wrote, len-wrote)) <= 0) {
			return wrote;
		}
		wrote += i;
	} while (wrote < len);

	return len;
}
