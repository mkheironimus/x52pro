#! /usr/bin/perl

use strict;
use warnings;

use AnyEvent;

use x52pro;

sub mfd_setup {
	my %args = (
		'js'  => undef,
		'led' => 32,
		'mfd' => 64,
		@_
	);
	# LED brightness
	x52pro::libx52_set_brightness($args{'js'}, 0, $args{'led'});
	# MFD light
	x52pro::libx52_set_brightness($args{'js'}, 1, $args{'mfd'});
	x52pro::libx52_update($args{'js'});
}

sub mfd_shutdown {
	my %args = (
		'js' => undef,
		@_
	);
	# Turn the lights off
	mfd_setup('js' => $args{'js'}, 'led' => 0, 'mfd' => 0);
	# Clean up
	x52pro::libx52_exit($args{'js'});
}

our $js = x52pro::libx52_init() or die('Unable to open X52 Pro');
our $finished = AnyEvent->condvar;

our $ev_sigint = AnyEvent->signal('signal' => 'INT',
	'cb' => sub { print("Interrupt\n"); $finished->send(); });

our $ev_sigterm = AnyEvent->signal('signal' => 'TERM',
	'cb' => sub { print("Terminated\n"); $finished->send(); });

our $ev_clock = AnyEvent->timer('interval' => 10,
	'cb' => sub { x52pro::update_clock($js, 1) });

mfd_setup('js' => $js);
$finished->recv();
mfd_shutdown('js' => $js);
undef $js;
exit 0;
