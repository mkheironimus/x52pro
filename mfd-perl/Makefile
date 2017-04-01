LIBX52_ROOT  := /usr/local
PERL_COMPILE := $(shell perl -MConfig -e 'print join(" ", @Config{qw(ccflags optimize cccdlflags)}, "-I$$Config{archlib}/CORE")')
PERL_LINK    := $(shell perl -MConfig -e 'print $$Config{lddlflags}')

all: x52pro.so

clean:
	rm -f x52pro.so x52pro_wrap.o x52pro_wrap.c x52pro.pm

.PHONY: clean

x52pro.so: x52pro_wrap.o
	gcc $(PERL_LINK) $< -lx52 -lx52util -o $@ -Wl,-rpath=$(LIBX52_ROOT)/lib

x52pro_wrap.o: x52pro_wrap.c
	gcc -c $(PERL_COMPILE) -o $@ $<

x52pro.pm x52pro_wrap.c: x52pro.i
	swig -perl5 -I$(LIBX52_ROOT)/include $<
