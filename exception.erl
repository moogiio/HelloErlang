-module(exception).
-export([divide/2, calculate/2, search_one/2, search/2]).

% Let it crash principle, only check for OK values aka whitelisting.


% Shell, divide(10, 5) -> 2
% Shell, divide(10, 0) -> Error
divide(A, B) when B == 0 ->
    error({divideByZero, A});
divide(A, B) ->
    A / B.

calculate(A, B) ->
    try divide(A, B) of
        Val -> {{A, B}, normal, Val}
    catch
        error:{diviByZero, _X} -> {divideByZero, error, {A, B}}
    after
        io:format("cleanup goes here\n")
    end.

%Search for element in list
% if not found exception is thrown {noFound, Element}
% if found more than one, exception is thrown {notUnique, Element}
% otherwise returns element
search_one(Element, List) ->
    Result = lists:filter(fun(X) -> X == Element end, List),
    if
        length(Result) == 0 -> throw({notFound, Element});
        length(Result) > 1 -> throw({notUnique, Element});
        true -> lists:nth(1, Result)
    end.

search(Element, List) ->
    try search_one(Element, List) of
        Value -> {ok, Value}
    catch
        % throw:{notFound, Element} -> notFound;
        % throw:{notUnique, Element} -> notUnique
        _:_ -> io:format("Incorrect input\n")
    end.