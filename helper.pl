sum_up(List, Total) :-
	sum_up(0, List, Total).

sum_up(X, [], X).
sum_up(SoFar, [H | T], Total) :-
	NT is H + SoFar,
	sum_up(NT, T, Total).
