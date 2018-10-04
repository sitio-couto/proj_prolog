main :- eof(I), fold(I,O), show(O).

eof(I) :- readln([L|_]) -> (eof(Ls), atom_codes(L,Lc), I=[Lc|Ls]) ; I = [].

show([Z|Zs]) :- Z\=[] -> format("~s~n",[Z]), show(Zs) ; !.

fold([],[]).
fold([L|Ls],R) :- comb(L,Ls,H,Hs) -> fold([H|Hs],R) ; (fold(Ls,Z), R = [L|Z]).

% Try to combine strings A-B or B-A util match or list end.
comb(H,[L|Ls],R,Rs) :- (join(H,L,R);join(L,H,R))->Rs=Ls;comb(H,Ls,R,T),Rs=[L|T].

% Join strings
join(A,B,L) :- intersect(A,B,I), length(I,N), N > 3, drop(B,N,R), append(A,R,L).

drop(B,0,B).
drop([_|Bs],N,R) :- X is N-1, drop(Bs,X,R).

% Check if B can be appended to A, returns the instersection.
intersect([A|As],B,C) :- substr([A|As],B) -> C = [A|As] ; intersect(As,B,C).

substr([],_).
substr([A|As],[B|Bs]) :- A==B, substr(As,Bs).
