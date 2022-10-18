-module(dynamic_counter).
-export([start/1, loop/2, sleep/0]).

start(Version) ->
    spawn(fun() -> loop(Version, 1) end).

loop(Version, Count) ->
    sleep(),
    Val = dynamic_code_loading:count(Count),
    io:format("Version 1 (~p) count:count() = ~p\n", [Version, Val]),
    loop(Version, Val).

sleep() ->
    receive
        after 5000 -> true
    end.