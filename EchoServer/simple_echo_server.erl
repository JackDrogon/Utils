-module(simple_echo_server).
-export([start/0, start/1, start/2]).

%% @doc: a simple echo server with accept_loop

%% TODO: add gen_server, monitor
%% TODO: add tcp rst deal
%% TODO: send nodelay

ip_to_string(IP) ->
    {A, B, C, D} = IP,
    lists:flatten(io_lib:format("~p.~p.~p.~p", [A, B, C, D])).

start(IP, Port) ->
    Option = [binary, {packet, 0}, {reuseaddr, true}, {active, true}, {ip, IP}],
    % Option = [binary, {packet, 0}, {reuseaddr, true}, {ip, {127, 0, 0, 1}}, {active, true}],
    io:format("Listening on ~s:~p.~n", [ip_to_string(IP), Port]),
    {ok, Listen} = gen_tcp:listen(Port, Option),
    % spawn(fun() -> accept_loop(Listen) end).
    accept_loop_pool(Listen, 4).

start(Port) ->
    start({127, 0, 0, 1}, Port).

start() ->
    start(1234).

accept_loop_pool(_Listen, 0) -> ok;
accept_loop_pool(Listen, N) ->
    spawn(fun() -> accept_loop(Listen) end),
    accept_loop_pool(Listen, N-1).

accept_loop(Listen) ->
    {ok, Socket} = gen_tcp:accept(Listen),
    {ok, {Address, Port}} = inet:peername(Socket),
    inet:setopts(Socket, [{nodelay, true}]),
    Pid = spawn(fun() -> echo_loop(Socket, {Address, Port}) end),
    gen_tcp:controlling_process(Socket, Pid),
    io:format("*** ~s:~p connected, deal with Pid:~p.~n", [ip_to_string(Address), Port, Pid]),
    accept_loop(Listen).

echo_loop(Socket, {Address, Port}) ->
    receive
        {tcp, Socket, Bin} ->
            io:format("~s", [Bin]),
            gen_tcp:send(Socket, Bin),
            echo_loop(Socket, {Address, Port});
        % TODO: add tcp_passive tcp_error deal
        {tcp_passive, Socket} ->
            ok;
        {tcp_closed, Socket} ->
            io:format("*** ~s:~p disconnected.~n", [ip_to_string(Address), Port]),
            gen_tcp:close(Socket);
        {tcp_error, Socket, Reason} ->
            io:format("TcpError: ~p~n.", [Reason])
    end.
