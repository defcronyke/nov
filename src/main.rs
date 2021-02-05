/*  Copyright (c) 2021 Jeremy Carter <jeremy@jeremycarter.ca>

    All uses of this project in part or in whole are governed
    by the terms of the license contained in the file titled
    "LICENSE" that's distributed along with the project, which
    can be found in the top-level directory of this project.

    If you don't agree to follow those terms or you won't
    follow them, you are not allowed to use this project or
    anything that's made with parts of it at all. The project
    is also	depending on some third-party technologies, and
    some of those are governed by their own separate licenses,
    so furthermore, whenever legally possible, all license
    terms from all of the different technologies apply, with
    this project's license terms taking first priority.
*/
use libnov;
use libnov::constant::*;
use libnov::file;

fn main() {
    println!("Starting Nov.");

    let mut file_content = Vec::<u8>::new();

    let (filename, _file_prefixes) = file::read(
        &mut file_content,
        Some(PROJECT_FILENAME),
        Some(PROJECT_FILE_PREFIXES.to_vec()),
    )
    .unwrap();

    if file_content.len() > 0 {
        println!("file loaded: {}", filename);
    }

    libnov::main();
}
