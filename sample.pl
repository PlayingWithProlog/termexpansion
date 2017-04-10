term_expansion(employee(ID, Name, Position),
	       ['$source_location'('myfile.pl', 34):name(ID, Name), position(ID, Position)]).

term_expansion(:- some_declarative,
	       ':-'(some_other_declarative) ).

employee(12345, 'Bob Jones', receptionist).
employee(54321, 'Sally Smith', 'software engineer').
