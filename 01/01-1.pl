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
    $position += $direction eq 'L' ? (0 - $amount) : $amount;

    # adjust for wraparounds
    $position -= 100 while $position > 99;
    $position += 100 while $position < 0;

    if ($position == 0) {
        $zero_counter++;
    }
}

print "We hit zero $zero_counter time(s)\n";