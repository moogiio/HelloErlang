-module(dynamic_functions).
-export([initialise_list/1, reverse/1]).

-define(LEFT, -1).
-define(RIGHT, 1).


initialise_list(N) ->
    create_list(N, []).

% Initialise new list with N entries (5) = [1,2,3,4,5]
create_list(0, List) ->
    List;
create_list(N, List) ->
    create_list(N - 1, [N | List]).

% Reverse List ([1,2,3]) => [3,2,1]
reverse([]) ->
    [];
reverse([H | T]) ->
    reverse(T) ++ [H].
