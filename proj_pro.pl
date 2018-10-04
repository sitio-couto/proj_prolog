% ["xxxxxababababyyyyyy","yyaaaaaaaaaaa","yyyyyyeeeeeeeeeeeeee","cccccccccccccccxxxxx","fffffffffffffffwwwwww","wwwwwwgggggggggggxx"]
% xxxxxababababyyyyyy\nyyaaaaaaaaaaa\nyyyyyyeeeeeeeeeeeeee\ncccccccccccccccxxxxx\nfffffffffffffffwwwwww\nwwwwwwgggggggggggxx
main :-
    open('trechos.txt', read, Str),
    file_read(Str,I),
    atom_codes(I,C),
    input(C,R),
    output(R),
    close(Str), !.

eof(end_of_file,_,'') :- !.
eof(Ap,S,I) :- get_char(S,A), eof(A,S,L), atom_concat(Ap,L,I).

file_read(S,I) :-
  get_char(S,A),
  eof(A,S,I).

input(I,S) :- lines(I,L,R), clean([L|R],S).
lines([],[],[]).
lines([10|Xs],L,R) :- lines(Xs,Lr,Rr), R = [Lr|Rr], L = [].
lines([X|Xs],L,R) :- lines(Xs,Lr,R), L = [X|Lr].
clean([],[]).
clean([X|Xs],S) :- clean(Xs,Z), (X==[] -> S = Z ; S = [X|Z]).

output(L) :- iterate(L,R), show(R).
show([Z|Zs]) :- format("~s~n",[Z]), show(Zs).
show([]).

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
