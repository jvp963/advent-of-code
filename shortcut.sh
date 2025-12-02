#!/bin/sh

aoc() {
    docker run --rm -i -v /Users/jvp/scratch/perl/aoc2025:/opt/ perl:aoc2025 carton exec perl /opt/$1/$1-$2.pl
}
