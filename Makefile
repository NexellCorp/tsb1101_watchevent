INCLUDES := -I../../sysroot/include
LDFLAGS := -L../../sysroot/lib
LIBS += -lpthread

CROSS_COMPILE ?= aarch64-linux-gnu-
CC = $(CROSS_COMPILE)gcc

SRCS_C := $(wildcard *.c)
OBJS_C := $(SRCS_C:.c=.o)

TARGET := watchevent

.c.o:
	$(CC) $(INCLUDES) $(CFLAGS) -c $^

$(TARGET): $(OBJS_C) buildtime.h
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS) $(LFLAGS)

install: $(TARGET)
	cp $^ ../../sysroot/bin

buildtime.h: 
	@echo '#ifndef	_BUILDTIME_H_' >  $@
	@echo '#define	_BUILDTIME_H_' >> $@
	@echo '' >> $@
	@date +'#define BUILDTIME "%Y%m%d_%H%M%S"' >> $@
	@echo '#endif' >> $@

all: $(TARGET)

.PHONY: clean

clean:
	rm -f *.o
	rm -f $(TARGET)

