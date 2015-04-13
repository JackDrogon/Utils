CC = gcc
CFLAGS = -DDEBUG

logger : logger.c
	$(CC) $(CFLAGS) -o $@ $^

.PHONY : logger.c

logger.c : logger.h

clean : logger
	-$(RM) -f logger
