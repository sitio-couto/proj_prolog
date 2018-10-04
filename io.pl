% swipl -q -g main proj2.pl < trechos
main :- eof(I), write(I).

eof(I) :- readln(L), L\=[] ->
  (eof(Ls), [Lh|_]=L, atom_codes(Lh,Lc), I=[Lc|Ls]); (I = []).

% input(I,S) :- lines(I,L,R), clean([L|R],S).
% lines([],[],[]).
% lines([10|Xs],L,R) :- lines(Xs,Lr,Rr), R = [Lr|Rr], L = [].
% lines([X|Xs],L,R) :- lines(Xs,Lr,R), L = [X|Lr].
% clean([],[]).
% clean([X|Xs],S) :- clean(Xs,Z), (X==[] -> S = Z ; S = [X|Z]).
%
show([Z|Zs]) :- write(Z), show(Zs).
show([Z|[]]).
