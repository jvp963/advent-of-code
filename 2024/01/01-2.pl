#!/usr/bin/perl

use strict;
use warnings;

my @nums1 = ( );
my @nums2 = ( );
while (<>) {
    next unless /^(\d+)\s+(\d+)\s?$/;
    push @nums1, $1;
    push @nums2, $2;
}

my @sorted1 = sort {$a <=> $b} @nums1;
my @sorted2 = sort {$a <=> $b} @nums2;

my $total = 0;
foreach (0..$#sorted1) {
    my $first = $sorted1[$_];
    my $matches = grep { $_ == $first } @sorted2;
    print "$sorted1[$_] appears $matches time\n";
    $total += $sorted1[$_] * $matches;
}

print "$total\n";
