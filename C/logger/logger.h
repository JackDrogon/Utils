#ifndef __LOGGER_H__
#define __LOGGER_H__

#include <stdio.h>

__BEGIN_DECLS
#ifdef DEBUG
#define logger(file,fmt,...) {\
	fprintf(file, "\033[1;31m" "Debug\t%s::%s:%d\t\t", __FILE__, __func__, __LINE__); \
	fprintf(file, fmt, ##__VA_ARGS__); \
	fprintf(file, "\033[0m"); \
}
#else
#define logger(file,fmt,...) fprintf(file, fmt, ##__VA_ARGS__);
#endif
__END_DECLS

#endif // __LOGGER_H__
