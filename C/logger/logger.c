#include "logger.h"

int main()
{
	logger(stderr, "%s\n", "Hello");
	puts("------------------------");
	logger(stderr, "%s\n", "Hello");
	logger(stderr, "%s\n", "Hello");

	return 0;
}
