# COSC 407/507 Lab 0
#
#   make          build ./baseline
#   make test     check your toolchain and your RESULTS.md
#   make clean

CC      := gcc
CFLAGS  := -std=gnu11 -O2 -Wall -Wextra -Iinclude
LDFLAGS := -pthread

.PHONY: all test clean

all: baseline

baseline: src/baseline.c include/timer.h
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ src/baseline.c

test: all
	bash tests/run_tests.sh

clean:
	rm -f baseline baseline.exe
