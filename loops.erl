-module(loops).
-export([for/3, fordown/3, range/4]).

% lib_misc.erl 

for(Max, Max, Func) ->
    [Func(Max)];
for(Index, Max, Func) ->
    [Func(Index)|for(Index + 1, Max, Func)].

fordown(Min, Min, Func) ->
    [Func(Min)];
fordown(Index, Min, Func) ->
    [Func(Index)|fordown(Index - 1, Min, Func)].

range(Max, Max, _, Func) ->
    [Func(Max)];
range(Index, Max, Step, Func) ->
    [Func(Index)|range(Step(Index), Max, Step, Func)].