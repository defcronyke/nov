@echo off
rem Copyright (c) 2021 Jeremy Carter jeremy@jeremycarter.ca
rem
rem All uses of this project in part or in whole are governed
rem by the terms of the license contained in the file titled
rem "LICENSE" that's distributed along with the project, which
rem can be found in the top-level directory of this project.
rem
rem If you don't agree to follow those terms or you won't
rem follow them, you are not allowed to use this project or
rem anything that's made with parts of it at all. The project
rem is also	depending on some third-party technologies, and
rem some of those are governed by their own separate licenses,
rem so furthermore, whenever legally possible, all license
rem terms from all of the different technologies apply, with
rem this project's license terms taking first priority.

rem You can change the gfx-hal backend to any of these:
rem
rem   vulkan, gl, dx12, dx11, metal, empty
rem
rem This is how you change it to OpenGL for example:
rem
rem   cargo run --features gl
rem

cmd /C "set pwd=%dir%&& cd ..\nob && .\build.bat %* && cd %pwd%"
cmd /C "set CARGO_TARGET_DIR=target-dx12&& cargo run --features dx12 --color always %*"
