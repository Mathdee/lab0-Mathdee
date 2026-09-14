# COSC 407 / 507 -- one toolchain for every lab this term.
#
# The point of this image is that nobody spends lab time on installation, and
# that every measurement in the course is taken on a comparable toolchain. It is
# used two ways, from the same definition:
#
#   * GitHub Codespaces -- nothing to install, runs in a browser
#   * Docker or Podman on your own machine -- for working offline
#
# Built and published by the course, not by students. See labs/_devcontainer/README.md.

FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# build-essential  gcc, make, libc headers
# clang            a second opinion on your code, and ThreadSanitizer
# gdb, valgrind    debugging, and Helgrind for race detection
# libomp-dev       OpenMP runtime, needed from Lab 4 onward
# hwloc            lstopo, so you can report what machine you measured on
# python3 + matplotlib  plotting scaling curves from Lab 4 onward
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential \
      clang \
      gdb \
      valgrind \
      libomp-dev \
      hwloc \
      python3 \
      python3-matplotlib \
      less \
      procps \
      time \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Make the core count obvious the moment a shell opens: every lab asks you to
# report it, and a timing without it is not a measurement.
RUN printf '%s\n' \
    'echo "COSC 407 lab container. $(nproc) cores visible. gcc $(gcc -dumpversion)."' \
    >> /etc/bash.bashrc

WORKDIR /workspaces
