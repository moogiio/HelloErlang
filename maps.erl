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