% swipl -q -g main proj2.pl < trechos
main :- eof(I), write(I).

eof(I) :- readln(L), L\=[] ->
  (eof(Ls), [Lh|_]=L, atom_codes(Lh,Lc), I=[Lc|Ls]); (I = []).
