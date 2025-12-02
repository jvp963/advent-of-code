# Advent of Code 2025

After building the perl:carton container, build the perl:aoc2025 container.

    docker build -t perl:aoc2025 .

To run the script from Docker we'll need to mount the current directory inside the container. I'll use /opt as the mount point. Here is the full command:

    docker run --rm -i -v c:/Users/USERNAME/some/path:/opt/ perl:aoc2025 carton exec perl /opt/<script.pl>
