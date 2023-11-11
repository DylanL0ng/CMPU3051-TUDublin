% Semantic Network example 1 in Prolog
% with some inference rules for navigating the knowledge network

is_a(cat, mammal).
is_a(bear, mammal).
is_a(mammal, animal).
is_a(bird, animal).
is_a(fish, animal).
is_a(whale, mammal).
is_a(trout, fish).
is_a(tom, cat).

has(bird, wings).
has(fish, scales).
has(cat, fur).
has(cat, tail).
has(bear, fur).
has(mammal, fur).
has(mammal, vertebra).

lives_in(fish, water).
lives_in(whale, water).

sat_on(cat, mat).

like(cat, cream).
like(cat, milk).

like(bird, insects).

caught(tom, bird).

is_owned_by(tom, john).

is_coloured(tom, ginger).

isa(A,B) :- is_a(A,B).
isa(A,B) :- is_a(A,C), isa(C,B).


has(A,B) :- isa(A,C), has(C,B).
lives_in(A,B) :- isa(A,C), lives_in(C, B).

instance(tommy, bear).
instance(moby, whale).
instance(fido, dog).
is_a(X,Y) :-instance(X,Y).