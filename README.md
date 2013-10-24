# Synopsis

Inside a dotCloud `run` file.

    #!/bin/bash
    :- use_module(library(dotcloud)).
    :- http_handler(/, hello, []).

    main(_) :-
        server('WWW').

    hello(_Request) :-
        format('Content-type: text/plain~n~n'),
        format('Hello Prolog, from dotCloud!~n').

# Description

A convenience library for working with
[SWI-Prolog on dotCloud](https://github.com/mndrix/swi-prolog-on-dotcloud).

# Changes in this Version

  * First public release

# Installation

Using SWI-Prolog 6.3 or later:

    ?- pack_install(dotcloud).

This module uses [semantic versioning](http://semver.org/).

Source code available and pull requests accepted at
http://github.com/mndrix/dotcloud

@author Michael Hendricks <michael@ndrix.org>
@license BSD
