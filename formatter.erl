-module(formatter).
-export([month/1]).

month(1) -> "January";
month(2) -> "Febraury";
month(3) -> "March";
month(_) -> "Not a month".