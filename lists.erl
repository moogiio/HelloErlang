-module(lists).

% List comprehension

% Run in erlang shell
Scores = [1,5,7,787,22,34,7654].
lists:map(fun(X) -> X / 2 end, Scores).

[X / 5 || X <- Scores].
%|-----| |--|
% ctor   pattern

GameScore = [{"John", 10}, {"Adam", 20}, {"George", 11}, {"Henry", 14}].
[{Name, Score > 12} || {Name, Score} <- GameScore]. 
%       |---------|
%        Logic here
[{"Adam", Score} || {"Adam", Score} <- GameScore].
% |-----|
%  query single tuple


