% Some example code to use in shell
% 
% 1. Scores = #{ "Adam" => 10, "John" => 20 }.
% 2. NewScores = Scores#{ "Pete" => 30}.
% 3. UpdatedScore = NewScores#{ "Pete" := 1337 }. (Obs, := operator)
% 4. TupleScores = maps:to_list(UpdatedScores).
% 5. OriginalScores = maps:from_list(TupleScores).
% 6. SizeOfScores = maps:size(OriginalScores).
% 7. AdamScore = maps.get("Adam", OriginalScores).
% 8. FindScore = maps:find("Adam", OriginalScores.
% 9. AllKeys = maps:keys(OriginalScores).
% 10. RemoveScore = maps:remove("Adam", OriginalScores).
% 11. ScoreWitout = maps:without(["Adam", "John"], RemoveScore).

-module(mapss).
-export([standardize_measures_to_cm/1]).

standardize_measures_to_cm(Measure) ->
    standardize_measures_to_cm(Measure, []).

standardize_measures_to_cm([{cm, _} = Measure | T], Acc) ->
    standardize_measures_to_cm(T, [Measure | Acc]);
standardize_measures_to_cm([{m, Value} | T], Acc) ->
    standardize_measures_to_cm(T, [{cm, round(Value * 100)} | Acc]).