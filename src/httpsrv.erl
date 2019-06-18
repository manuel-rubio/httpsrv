-module(httpsrv).
-author('manuel@altenwald.com').

-define(PORT, 8080).

-export([main/1]).

main([]) ->
    application:ensure_all_started(cowboy),
    Port = ?PORT,
    io:format("HTTP Server - Initiating in port ~b~n", [Port]),
    {ok, _} = start_link(Port),
    io:format("Listening...~n", []),
    io:get_line("Press ENTER to exit "),
    halt(0).

dispatch() ->
    cowboy_router:compile([{'_', [
        {"/[...]", cowboy_static, {dir, "."}}
    ]}]).

start_link(PortNumber) ->
    Opts = #{env => #{dispatch => dispatch()}},
    Port = [{port, PortNumber}, inet],
    {ok, _} = cowboy:start_clear(?MODULE, Port, Opts).
