-module(m_erlang_sup).
-behaviour(supervisor).

-export([start_link/0, init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    io:format("Supervisor: Starting up~n"),
    Port = 8092,
    Dispatch = cowboy_router:compile([
                  {'_', [
                      {"/hello", m_erlang_hello_handler, []},
                      {"/handshake", m_erlang_handshake_handler, []}
                  ]}
              ]),
    {ok, _} = cowboy:start_clear(my_http_listener,
                                 [{port, Port}],
                                 #{env => #{dispatch => Dispatch}}),
    io:format("Supervisor: HTTP server is running on port ~p~n", [Port]),
    {ok, {{one_for_one, 5, 10}, []}}.
