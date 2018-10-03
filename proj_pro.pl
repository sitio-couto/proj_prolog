% ["xxxxxababababyyyyyy","yyaaaaaaaaaaa","yyyyyyeeeeeeeeeeeeee","cccccccccccccccxxxxx","fffffffffffffffwwwwww","wwwwwwgggggggggggxx"]

:- dynamic seq/1.

seq(B) :- string_codes("xxxxxababababyyyyyy",B).
seq(B) :- string_codes("yyaaaaaaaaaaa",B).
seq(B) :- string_codes("yyyyyyeeeeeeeeeeeeee",B).
seq(B) :- string_codes("cccccccccccccccxxxxx",B).
seq(B) :- string_codes("fffffffffffffffwwwwww",B).
seq(B) :- string_codes("wwwwwwgggggggggggxx",B).

% seq('xxxxxababababyyyyyy').
% seq('yyaaaaaaaaaaa').
% seq('yyyyyyeeeeeeeeeeeeee').
% seq('cccccccccccccccxxxxx').
% seq('fffffffffffffffwwwwww').
% seq('wwwwwwgggggggggggxx').


% findall(S,(seq(A),seq(B),A\=B,joinstr(A,B,X),string_codes(S,X)),L).

% Check if B can be appended to A, returns the instersection.
intersect([A|As],B,C) :-
    substr([A|As],B) -> C = [A|As] ; intersect(As,B,C).

substr([],_) :- !.
substr([A|As],[B|Bs]) :- A==B, substr(As,Bs).

% Join strings
joinstr(A,B,L) :-
  intersect(A,B,I), length(I,N),
  N > 3 -> drop(B,N,R), append(A,R,L),
  % retract(seq(A)), retract(seq(B)),
  assertz(seq(L)).

drop(B,0,B).
drop([_|Bs],N,R) :- X is N-1, drop(Bs,X,R).
