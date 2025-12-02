# Advent of Code 2025

These scripts can be run with a stock Perl installation--check the cpanfile for
any extra modules that need to be installed. Alternatively, they can be run with
docker (based on my perl:carton docker container which you can find/build at https://github.com/jvp963/perldev).

After building the perl:carton container, build the perl:aoc2025 container.

    docker build -t perl:aoc2025 .

To run the script from Docker we'll need to mount the current directory inside the container. I'll use /opt as the mount point. Here is the full command:

    docker run --rm -i -v c:/Users/USERNAME/some/path:/opt/ \
        perl:aoc2025 carton exec perl /opt/<script.pl>

Also included is a shell alias that simplifies this command. It depends on the a certain directory structure where the scripts are located, examine the script for more info. It takes two positional arguments:

- The day of the challenge (two digits, zero-padded)
- The puzzle number (1 or 2)

For example: 

    . ./shortcut.sh
    cat input | aoc 01 1
