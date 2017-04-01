#! /usr/bin/perl

use strict;
use warnings;

use AnyEvent;

use x52pro;

sub update_clock {
	my %args = (
		'x52'   => undef,
		'time'  => time(),
		'local' => 1,
		@_
	);
	print("Clock.\n");
	if (x52pro::libx52_set_clock($args{'x52'}, $args{'time'}, $args{'local'}) == 0) {
		print("Updating.\n");
		x52pro::libx52_update($args{'x52'});
	}
}

our $js = x52pro::libx52_init() or die('Unable to open X52 Pro');
our $finished = AnyEvent->condvar;
our $ev_sigint = AnyEvent->signal(
	'signal' => 'INT',
	'cb' => sub { print("Interrupt\n"); $finished->send(); }
);
our $ev_clock = AnyEvent->timer(
	'interval' => 10,
	'cb' => sub { update_clock('x52' => $js) },
);

$finished->recv();
x52pro::libx52_exit($js);
undef $js;
exit 0;
