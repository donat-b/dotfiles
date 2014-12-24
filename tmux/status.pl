#!/usr/bin/env perl
use strict;
use warnings;
use diagnostics;
use Sys::Hostname;

#use Benchmark;

#timethese( 10000000, {
#});

printf('%s ', hostname);
if open( BAT0, '/sys/class/power_supply/BAT0/status' ) {
	while( <BAT0> ) {
	printf('%s', hostname);
	}
}
