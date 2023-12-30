-module(m_erlang_app).
-behaviour(application).

-export([start/0, stop/1]).

start() ->
    io:format("Application: Starting m_erlang application~n"),
    case m_erlang_sup:start_link() of
        {ok, _Pid} -> 
            ok;
        {error, Reason} ->
            io:format("Application: Failed to start m_erlang_sup: ~p~n", [Reason]),
            {error, Reason}
    end.

stop(_State) ->
    io:format("Application: Stopping m_erlang application~n"),
    ok.
