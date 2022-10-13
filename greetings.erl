-module(greetings).
-export([greet/3]).

greet(Name, Language, Age) ->
    case Language of
        polish when Age < 18 -> io:format("Witaj, ~s\n", [Name]);
        polish -> io:format("Witaj, Panie ~s\n", [Name]);
        english when Age < 18 -> io:format("Hello, ~s\n", [Name]);
        english -> io:format("Hello, Mr. ~s\n", [Name]);
        spanish when Age < 18 -> io:format("Hola, ~s\n", [Name]);
        spanish -> io:format("Hola, Sẽnore~s\n", [Name])
    end.