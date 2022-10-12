-module(funs).
-export([]).

%Use in Erlang shell
Greetings = fun(Greeting) -> (fun(Name) -> io:format("~s, ~s\n",[Greeting, Name]) end) end.

Hello = Greetings("Hello").

