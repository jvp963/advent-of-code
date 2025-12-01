#!/usr/bin/perl

use strict;
use warnings;

my $position = 50;
my @movements = ( );
while (<>) {
    chomp;
    push @movements, $_;
}

my $zero_counter = 0;
foreach (@movements) {
    next unless /^([LR])(\d+)$/;
    my $direction = $1;
    my $amount = $2;

    # turn dial
    my $increment = $direction eq 'L' ? -1 : 1;
    foreach (1..$amount) {
        $position += $increment;

        # account for overruns
        $position = 0 if $position == 100;
        $position = 99 if $position == -1;

        # did this click make us land on zero?
        if ($position == 0) {
            $zero_counter++;
        }
    }
}

print "We landed on zero or passed zero $zero_counter time(s)\n";