:- module(dotcloud, [server/1, server/2]).
:- reexport(library(http/http_dispatch)).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).


%% server(+Service:atom, :Goal) is det.
%
%  Start HTTP service named Service. Service should match the name of a
%  service configured in your dotloud.yml file. During deployment,
%  dotCloud assigns a port on which the service must listen.
%
%  For convenience during development, if the environment variable
%  'PORT_$Service' is not set, listen on port 3000.
:- meta_predicate server(+,1).
server(ServiceAtom, Goal) :-
    % on which port should we listen?
    upcase_atom(ServiceAtom, ServiceName),
    format(atom(Env), 'PORT_~w', [ServiceName]),
    getenv_default(Env, '3000', PortAtom),
    atom_number(PortAtom, Port),

    % start an HTTP server there
    http_server(Goal, [port(Port), keep_alive_timeout(1)]),
    format('Listening on port ~d~n', [Port]),
    format(atom(Thread), 'http@~d', [Port]),

    % wait for the server to exit
    thread_join(Thread, _).


%% server(+ServiceAtom:atom) is det.
%
%  Like server/2 but uses http_dispatch/1 as the Goal.
server(ServiceAtom) :-
    server(ServiceAtom, http_dispatch).


% retrieve an environment variable with a fallback default value
getenv_default(Name, Default, Value) :-
    ( getenv(Name, Value0) ->
        Value = Value0
    ; true ->
        debug(dotcloud, 'No ~w environment. Defaulting to ~w', [Name, Default]),
        Value = Default
    ).
