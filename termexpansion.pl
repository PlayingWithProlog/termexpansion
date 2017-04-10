:- module(termexpansion, []).


/*******************************
* Conditional Compilation      *
*
* example implements conditional
* compilation as a
*******************************/

:- dynamic termexpansion:'$nocompile$'/0.

termexpansion:cond_compile :-
	retractall(termexpansion:'$nocompile$').

termexpansion:cond_no_compile :-
	asserta(termexpansion:'$nocompile$').

user:term_expansion(':-'(termexpansion:cond_compile), []) :-
	retractall(termexpansion:'$nocompile$'),
	writeln('*** cond_compile').
user:term_expansion(end_of_file, end_of_file) :-
	retractall(termexpansion:'$nocompile$'),
	writeln('*** end of file').
user:term_expansion(In, []) :-
	termexpansion:'$nocompile$',
	In \= ':-'(termexpansion:cond_compile),
	In \= end_of_file,
	format('false  ~w~n', [In]).

	         /*******************************
	         *        goal expansion
		 *******************************/

user:goal_expansion(flying_burrito(X), flying_taco(X)) :-
	format('goal expand flying_burrito ~w~n', [X]).

		 /*******************************
		 * indexing
		 *******************************/

:- nb_setval(fun_saying_index, 0).

% don't need to be in user
term_expansion(fun_saying(Saying), fun_saying(Index, Saying)) :-
	nb_getval(fun_saying_index, Index),
	succ(Index, NIndex),
	nb_setval(fun_saying_index, NIndex).

		 /*******************************
		 *  test examples          *
		 *******************************/

% conditional compilation
%
:- termexpansion:cond_no_compile.

foo(7).  % wont be compiled
% bizarrely current_functor(foo, 1) succeeds

:- termexpansion:cond_compile.

:- (  current_predicate(foo/1)
   ->  writeln('OOOooops, foo should not be defined')
   ;  writeln('this must be printed')
   ).

flying_taco(X) :-
	format('I am the true flying taco ~w~n', [X]).

flying_burrito(7). % no expansion, not in body, but will expand goal.

flying_enchilada :-
	flying_burrito(12).

fun_saying('Never give a Python programmer a line break').
fun_saying('There are 10 types of people in the world, those that understand binary and those that don\'t').
fun_saying('Endless Loop: n., see Loop, Endless.\nLoop, Endless: n., see Endless Loop.').
fun_saying('Never put off until run time what you can do at compile time.').


