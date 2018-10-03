% ["xxxxxababababyyyyyy","yyaaaaaaaaaaa","yyyyyyeeeeeeeeeeeeee","cccccccccccccccxxxxx","fffffffffffffffwwwwww","wwwwwwgggggggggggxx"]

% Check if B can be appended to A, returns the instersection.
intersect([A|As],B,C) :-
    substr([A|As],B) -> C = [A|As] ; intersect(As,B,C).

substr([],_) :- !.
substr([A|As],[B|Bs]) :- A==B, substr(As,Bs).

% Join strings
joinstr(A,B,L) :-
  intersect(A,B,I), length(I,N),
  N > 3 -> drop(B,N,R), append(A,R,L) ; L = A.

drop(B,0,B).
drop([_|Bs],N,R) :- X is N-1, drop(Bs,X,R).
