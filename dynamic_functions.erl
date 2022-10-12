-module(dynamic_functions).
-export([dynamic_list/1, reverse/1]).

dynamic_list(N) ->
    create_list(N, []).


create_list(0, List) ->
    List;
create_list(N, [H | T]) ->
    create_list(N - 1, [T] ++ [H]).

reverse([]) ->
    [];
reverse([H | T]) ->
    reverse(T) ++ [H].