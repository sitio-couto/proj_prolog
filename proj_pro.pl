main :- gip(I), exec(I,O), show(O). % Get input, execute code and show output.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gip(I) :- readln([L|_]) -> (gip(Ls), atom_codes(L,Lc), I=[Lc|Ls]) ; I = [].

exec([],[]).
exec([L|Ls],R) :- comb(L,Ls,H,Hs) -> exec([H|Hs],R) ; (exec(Ls,Z), R = [L|Z]).

show([Z|Zs]) :- Z\=[] -> format("~s~n",[Z]), show(Zs).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Try to combine strings A-B or B-A util match or list end.
comb(H,[L|Ls],R,Rs):- (join(H,L,R);join(L,H,R))->Rs=Ls; comb(H,Ls,R,T),Rs=[L|T].

% Join strings is there is a instersection I and |I|>3.
join(A,B,L) :- intersect(A,B,I), length(I,N), N > 3, drop(B,N,R), append(A,R,L).
drop([_|Bs],N,R) :- N\=1 -> (X is N-1, drop(Bs,X,R)) ; R=Bs.

% Check if B can be appended to A, returns the instersection.
intersect([A|As],B,C) :- substr([A|As],B) -> C = [A|As] ; intersect(As,B,C).
substr([A|As],[B|Bs]) :- A\=[], A==B, substr(As,Bs).
