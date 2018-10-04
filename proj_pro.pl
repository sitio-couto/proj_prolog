:- dynamic seq/1.

% Main function, read input, compute, print output
main :-
    readpred,
    findall(_,pred(seq(_),seq(_),_),_),
    findall(A, seq(A), E), maplist(writeln, E).

% Read input and assert predicate
readpred :-
    repeat,
    read_string(user_input, "\n", "\r\t ", End, String),
    ( End == -1
      -> !;
      assertz(seq(String)),
      fail
    ).

% Check if B can be appended to A, returns the instersection.
intersect([A|As],B,C) :-
    substr([A|As],B) -> C = [A|As] ; intersect(As,B,C).

substr([],_) :- !.
substr([A|As],[B|Bs]) :- A==B, substr(As,Bs).

% Manage predicates
pred(seq(A),seq(B),C) :-
    seq(A), seq(B), A\=B,
    string_codes(A,Alist), string_codes(B,Blist),
    joinstr(Alist,Blist,Clist), string_codes(C,Clist),
    retract(seq(A)), retract(seq(B)),
    not(seq(C)), assertz(seq(C)).

% Join strings
joinstr(A,B,L) :-
    intersect(A,B,I), length(I,N),
    N > 3 -> drop(B,N,R), append(A,R,L).

drop(B,0,B).
drop([_|Bs],N,R) :- X is N-1, drop(Bs,X,R).
