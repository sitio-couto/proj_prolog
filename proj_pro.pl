


% Check if B can be appended to A, returns the instersection.
intersect([A|As],B,C) :-
    substr([A|As],B) -> C = [A|As] ; intersect(As,B,C).

substr([],_) :- !.
substr([A|As],[B|Bs]) :- A==B, substr(As,Bs).

% Join strings
joinstr(A,B,I,L) :- length(I,N), drop(B,N,R), append(A,R,L).

drop(B,0,B).
drop([_|Bs],N,R) :- X is N-1, drop(Bs,X,R).
