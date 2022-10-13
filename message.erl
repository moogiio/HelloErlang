-module(message).
-include("record.hrl").
-export([print_message/1, update_sender/2, is_message/1]).

% For shell, read record: rr("record.hrl").

print_message(#message{sender=S, receiver=R, text=T} = M) ->
    io:format("Message\n"),
    io:format("From: ~s", [S]),
    io:format("To: ~s", [R]),
    io:format("Text: ~s\n\n", [T]).

% For shell: Message = #message{sender="Adam", receiver="Peter", text="Hello Peter, this is Adam"}.

update_sender(Sender, #message{} = M) ->
    M#message{sender=Sender}.

is_message(M) when is_record(M, message) ->
    true;
is_message(M) ->
    false.