-module(avg).
-export([avg/1]).

avg(L) ->
    sum(L) / length(L).

sum([]) ->
    0;
sum([{_, Score} | T]) ->
    Score + sum(T).
