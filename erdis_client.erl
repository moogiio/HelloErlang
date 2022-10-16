-module(erdis_client).
-export([client_set/2, client_get/1, client_size/0, client_keys/0, client_delete/1, client_exists/1]).

client_eval(Str) ->
    {ok, Socket} = gen_tcp:connect("localhost", 10101, [binary, {packet, 4}]),
    ok = gen_tcp:send(Socket, term_to_binary(Str)),
    receive
        {tcp, Socket, Bin} ->
            io:format("Client receive binary = ~p\n", [Bin]),
            Val = binary_to_term(Bin),
            io:format("Client result = ~p\n", [Val]),
            gen_tcp:close(Socket)
    end.

client_set(Key, Value) ->
    Command = io_lib:format("set ~s ~s", [Key, Value]),
    client_eval(Command).

client_get(Key) ->
    Command = io_lib:format("get ~s", [Key]),
    client_eval(Command).

client_size() ->
    Command = "size",
    client_eval(Command).

client_keys() ->
    Command = "keys",
    client_eval(Command).

client_delete(Key) ->
    Command = io_lib:format("delete ~s", [Key]),
    client_eval(Command).

client_exists(Key) ->
    Command = io_lib:format("exists ~s", [Key]),
    client_eval(Command).