-module(m_erlang_handshake_handler).
-behaviour(cowboy_handler).
-export([init/3]).

init(Req0, Transport, Opts) ->
    io:format("Handshake handler received a request~n"),
    {ok, Body, Req} = cowboy_req:read_body(Req0),
    BodyText = binary_to_list(Body),
    RequestText = lists:concat([BodyText, " Hello from Erlang microservice!"]),
    
    io:format("Sending handshake to external service~n"),
    {ok, {{_, 200, _}, _, ResponseBody}} = httpc:request(post, {"http://host.docker.internal:8888/handshake", [], "text/plain", RequestText}, [], []),
    
    io:format("Replying to request~n"),
    {ok, Req2} = cowboy_req:reply(200, #{<<"content-type">> => <<"text/plain">>}, ResponseBody, Req),
    {ok, Req2, Opts}.
