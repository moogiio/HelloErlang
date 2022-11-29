-module(recursion).
-export([reverse_list/1]).
-export([convert_list_to_binary/1]).

reverse_list(List) ->
    reverse_list(List, []).


reverse_list([], ReversedAcc) -> ReversedAcc;
reverse_list([H | T], ReversedAcc) ->
    reverse_list(T, [H|ReversedAcc]).

convert_list_to_binary(List) ->
    convert_list_to_binary(List, <<>>).
convert_list_to_binary([], Acc) -> Acc;
convert_list_to_binary([H|T], Acc) ->
    convert_list_to_binary(T, <<Acc/binary, H>>).