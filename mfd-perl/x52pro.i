%module x52pro
%{
#include <time.h>
#include <x52pro/libx52.h>
#include <x52pro/libx52util.h>

int update_clock(libx52_device *x52, int local)
{
    int rc = libx52_set_clock(x52, time(NULL), local);
    if (rc == 0)
        rc = libx52_update(x52);
    return rc;
}
%}

%include "stdint.i"
%include "x52pro/libx52.h"
%include "x52pro/libx52util.h"

typedef long time_t;

int update_clock(libx52_device *x52, int local);
