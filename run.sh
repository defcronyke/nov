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

# You can change the gfx-hal backend to any of these:
#
#   vulkan, gl, dx12, dx11, metal, empty
#
# This is how you change it to OpenGL for example:
#
#   cargo run --features gl
#

pwd="$PWD"
cd ../nob
./build.sh $@
cd "$pwd"

export PYTHON_SYS_EXECUTABLE="$(pyenv which python)"

export LIBPYTHON_DIR="$(pyenv prefix)/lib"
export LIBPYTHON_NAME="$(basename $(ls -1t $(pyenv prefix)/lib/libpython*.a | head -n 1) | sed 's/lib//' | sed 's/\.a//')"

# cat ".cargo/config.tmpl" | \
# sed "s@{LIBPYTHON_DIR}@$LIBPYTHON_DIR@g" | \
# sed "s@{LIBPYTHON_NAME}@$LIBPYTHON_NAME@g" | \
# tee ".cargo/config"

cargo run --features vulkan,python --color always $@
