-module(factorial).
-export([calc/1]).
-export([fact/1]).

calc(0) -> 
    1;
calc(1) ->
    1;
calc(N) ->
    N * calc(N - 1).

fact(0) -> 1;
fact(1) -> 1;
fact(N) -> N * fact(N - 1).