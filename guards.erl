-module(guards).
-export([factorial/1, range/1]).
-export([is_domestic/1]).
-define(DOMESTIC_ANIMALS, [cat, dog, horse]).
%Guards always resolve till true/false

%factiorial without guards
%factorial(0) ->
 %   1;
%factorial(1) ->
 %   1;
%factorial(N) ->
 %   N * factorial(N - 1).

%factorial with guards
factorial(N) when N < 2 ->
    1;     % | GUARD   |
factorial(N) ->
    N * factorial(N - 1).


%range(X) when is_integer(X), X > 10, X < 100 -> ALL guards must be true
range(X) when is_integer(X); X > 10; X < 100 -> % Only one guard need to be true (guard sequece)
    io:format("~w is in range\n", [X]);
range(X) ->
    io:format("~w is not in range\n", [X]).

is_domestic(Animal) ->
    lists:member(Animal, ?DOMESTIC_ANIMALS).