% ["xxxxxababababyyyyyy","yyaaaaaaaaaaa","yyyyyyeeeeeeeeeeeeee","cccccccccccccccxxxxx","fffffffffffffffwwwwww","wwwwwwgggggggggggxx"]

:- dynamic seq/1.

seq("xxxxxababababyyyyyy").
seq("yyaaaaaaaaaaa").
seq("yyyyyyeeeeeeeeeeeeee").
seq("cccccccccccccccxxxxx").
seq("fffffffffffffffwwwwww").
seq("wwwwwwgggggggggggxx").

% findall(S,(pred(seq(A),seq(B),X),string_codes(S,X)),L).

% Check if B can be appended to A, returns the instersection.
intersect([A|As],B,C) :-
    substr([A|As],B) -> C = [A|As] ; intersect(As,B,C).

substr([],_) :- !.
substr([A|As],[B|Bs]) :- A==B, substr(As,Bs).

% Manage predicates
pred(seq(A),seq(B),Cstring) :-
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
