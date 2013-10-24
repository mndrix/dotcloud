:- module(dotcloud, [server/1]).
:- reexport(library(http/http_dispatch)).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).

server(ServiceName) :-
    format(atom(Env), 'PORT_~w', [ServiceName]),
    getenv(Env, PortAtom),
    atom_number(PortAtom, Port),
    http_server(http_dispatch, [port(Port), keep_alive_timeout(1)]),
    format('Listening on port ~d~n', [Port]),
    format(atom(Thread), 'http@~d', [Port]),
    thread_join(Thread, _).
