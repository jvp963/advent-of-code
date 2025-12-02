 # Advent of Code Solutions

These scripts can be run with a stock Perl installation--check the cpanfile for
any extra modules that need to be installed. Alternatively, they can be run with
docker (based on my perl:carton docker image which you can find/build at
https://github.com/jvp963/perldev).

After building the perl:carton image, build the perl:advent-of-code image.

    docker build -t perl:advent-of-code .

To run a script with carton using a docker container we'll need to mount the current directory inside the container. I'll use /opt as the mount point. Here is the full command:

    docker run --rm -i -v /path/to/script/location:/opt/ perl:advent-of-code \
        carton exec perl /opt/<script.pl>

Also included is a shell alias that simplifies this command. It depends on the a certain directory structure where the scripts are located--examine the script for more info. It takes three positional arguments:

- The year of the challenge (four digits)
- The day of the challenge (two digits, zero-padded)
- The puzzle number (1 or 2)

For example: 

    $ . ./shortcut.sh              # set up command-line function
    $ cat input | aoc 2025 01 1    # run day 1, puzzle 1 script



