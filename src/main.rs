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

use libnov::{conf, view::*, window::*};

fn main() {
    println!(
        "Starting Nov...

You can run this with a filename as the first \
argument to specify which image to load, otherwise \
a default image will be loaded.
"
    );

    let res = libnov::main(Ok(()), |view: &mut View, res| {
        println!("{} is available.", view.get_name());

        #[cfg(feature = "python")]
        {
            let py = view.python.acquire_gil();

            py.import("sys").unwrap();

            py.eval(
                "print('!!!!!!!!!!!! HELLO PYTHON !!!!!!!!!!!!')",
                None,
                None,
            )
            .unwrap();
        }

        // This must run last.
        Window::new(conf::load(None)?).open_image(res.clone());

        res
    });

    std::process::exit(libnov::exit(res));
}
