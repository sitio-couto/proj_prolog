main :-
    open('trechos1.txt', read, Str),
    file_read(Str,I),
    atom_codes(I,C),
    input(C,R),
    show(R),
    close(Str).

eof(end_of_file,_,'') :- !.
eof(Ap,S,I) :- get_char(S,A), eof(A,S,L), atom_concat(Ap,L,I).

file_read(S,I) :-
  get_char(S,A),
  eof(A,S,I).

input(I,S) :- lines(I,L,R), clean([L|R],S).
lines([],[],[]).
lines([10|Xs],L,R) :- lines(Xs,Lr,Rr), R = [Lr|Rr], L = [].
lines([X|Xs],L,R) :- lines(Xs,Lr,R), L = [X|Lr].
clean([],[]).
clean([X|Xs],S) :- clean(Xs,Z), (X==[] -> S = Z ; S = [X|Z]).

show([Z|Zs]) :- format("~s~n",[Z]), show(Zs).
show([]).
