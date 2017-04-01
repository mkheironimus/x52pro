#! /usr/bin/perl

use strict;
use warnings;

use x52pro;

my $js = x52pro::libx52_init();
if (! defined($js)) {
	print("No stick.\n");
	exit 1;
}
print($js, "\n");
x52pro::libx52_set_brightness($js, 0, 64);
x52pro::libx52_set_brightness($js, 1, 64);
print("Setting shift indicator.\n");
x52pro::libx52_set_shift($js, 1);
print("Setting T1 to amber.\n");
x52pro::libx52_set_led_state($js, $x52pro::LIBX52_LED_T1, $x52pro::LIBX52_LED_STATE_AMBER);
print("Setting clock.\n");
x52pro::libx52_set_clock($js, time(), 1);
x52pro::libx52_update($js);
sleep 5;
print("Clearing shift indicator.\n");
x52pro::libx52_set_shift($js, 0);
print("Setting T1 to green.\n");
x52pro::libx52_set_led_state($js, $x52pro::LIBX52_LED_T1, $x52pro::LIBX52_LED_STATE_GREEN);
x52pro::libx52_set_brightness($js, 0, 0);
x52pro::libx52_set_brightness($js, 1, 0);
x52pro::libx52_update($js);
print("Closing stick: ", x52pro::libx52_exit($js), "\n");
exit 0;
