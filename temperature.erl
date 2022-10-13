-module(temperature).
-export([check_temp/1]).

check_temp(Temp) ->
    if
        Temp < 40 ->
            io:format("Temperature is OK\n");
        Temp > 40 ->
            io:format("It's getting hot\n");
        true ->
            io:format("This is the default case")
    end.