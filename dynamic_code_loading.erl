-module(dynamic_code_loading).
-export([count/1]).

count(Value) ->
    Value + 2.