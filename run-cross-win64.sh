#!/bin/bash
# Copyright (c) 2021 Jeremy Carter <jeremy@jeremycarter.ca>
#
# All uses of this project in part or in whole are governed
# by the terms of the license contained in the file titled
# "LICENSE" that's distributed along with the project, which
# can be found in the top-level directory of this project.
#
# If you don't agree to follow those terms or you won't
# follow them, you are not allowed to use this project or
# anything that's made with parts of it at all. The project
# is also	depending on some third-party technologies, and
# some of those are governed by their own separate licenses,
# so furthermore, whenever legally possible, all license
# terms from all of the different technologies apply, with
# this project's license terms taking first priority.

# This script will cross-compile the project for Windows 
# 64-bit from Linux.

pwd="$PWD"
cd ../nob
./build.sh $@
cd "$pwd"

rustup target add x86_64-pc-windows-gnu
rustup toolchain install stable-x86_64-pc-windows-gnu

mkdir -p python-cross-win64
cd python-cross-win64

if [ ! -d "Python-3.9.1" ]; then
  echo "Installing win64 version of Python for cross-compiling."
  wget "https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tar.xz"
  wget "https://www.python.org/ftp/python/3.9.1/python-3.9.1-embed-amd64.zip"
  tar xf Python-3.9.1.tar.xz
  unzip python-3.9.1-embed-amd64.zip
  cp python39.dll python3.9.dll
fi

mkdir -p ../target-cross-win64/x86_64-pc-windows-gnu/debug/

cp python39.dll python3.9.dll ../target-cross-win64/x86_64-pc-windows-gnu/debug/

cd ..

# export PYO3_CROSS_INCLUDE_DIR="$(pyenv prefix)/include/python3.9"
export PYO3_CROSS_INCLUDE_DIR="/usr/include/python3.9"
export PYO3_CROSS_LIB_DIR="$PWD/python-cross-win64"

export PYTHON_SYS_EXECUTABLE="$PWD/python-cross-win64/python.exe"
export PYTHONHOME="$PWD/python-cross-win64/Python-3.9.1"

# NOTE: On Windows (or maybe just Wine), python will only check one PYTHONPATH.
# So we symlink our module to that location.
cd python-cross-win64/Python-3.9.1
ln -sf ../../../libnov/data/src/nov
cd ../..

export PYTHONPATH="$PWD/python-cross-win64/Python-3.9.1"

# export PYTHONPATH="$PWD/../libnov/data/src"
# export PYTHONPATH="$PWD/python-cross-win64/Python-3.9.1:$PWD/../libnov/data/src:$PYTHONPATH"


# cat ".cargo/config.tmpl" | \
# sed "s@{LIBPYTHON_DIR}@$LIBPYTHON_DIR@g" | \
# sed "s@{LIBPYTHON_NAME}@$LIBPYTHON_NAME@g" | \
# tee ".cargo/config"

# cargo run --features vulkan,python --color always $@

RUST_BACKTRACE=full CARGO_TARGET_DIR=target-cross-win64 cargo run --features vulkan,python --target x86_64-pc-windows-gnu --verbose --color always $@
