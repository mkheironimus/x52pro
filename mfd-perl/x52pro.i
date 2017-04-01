%module x52pro
%{
#include <x52pro/libx52.h>
#include <x52pro/libx52util.h>
%}
typedef long time_t;
%include "stdint.i"
%include "x52pro/libx52.h"
%include "x52pro/libx52util.h"
