% ["xxxxxababababyyyyyy","yyaaaaaaaaaaa","yyyyyyeeeeeeeeeeeeee","cccccccccccccccxxxxx","fffffffffffffffwwwwww","wwwwwwgggggggggggxx"]
output(L) :- iterate(L,R), show(R).
show([Z|Zs]) :- format("~s~n",[Z]), nl, show(Zs).

iterate([],[]).
iterate([L|Ls],R) :-
  combine(L,Ls,H,Hs) -> iterate([H|Hs],R) ; (iterate(Ls,Z), R = [L|Z]).

% Try to combine strings A-B or B-A util match or list end.
combine(H,[L|Ls],R,Rs) :- (joinstr(H,L,R) ; joinstr(L,H,R)), Rs = Ls.
combine(H,[L|Ls],R,Rs) :- combine(H,Ls,R,T), Rs = [L|T].

% Join strings
joinstr(A,B,L) :-
  intersect(A,B,I), length(I,N), N > 3, drop(B,N,R), append(A,R,L).

drop(B,0,B).
drop([_|Bs],N,R) :- X is N-1, drop(Bs,X,R).

% Check if B can be appended to A, returns the instersection.
intersect([A|As],B,C) :- substr([A|As],B) -> C = [A|As] ; intersect(As,B,C).

substr([],_).
substr([A|As],[B|Bs]) :- A==B, substr(As,Bs).
