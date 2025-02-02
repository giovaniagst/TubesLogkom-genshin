:- include('battle.pl').
:- include('shop.pl').
:- include('quest.pl').

:- dynamic(playing/1).
:- dynamic(lebarpeta/1).
:- dynamic(tinggipeta/1).
:- dynamic(store/2).
:- dynamic(pagar/2).
:- dynamic(quest/2).
:- dynamic(enemy/2).
:- dynamic(dungeon/2).
:- dynamic(bossappear/1).
:- dynamic(takeaquest/1).
:- dynamic(enemyappear/1).

lebarpeta(15).
tinggipeta(15).

mulai :-
	asserta(store(13,8)),
	asserta(dungeon(13,12)),
	asserta(quest(13,2)),
	/* asserta(player(2,2)), */
	asserta(pagar(10,1)),
	asserta(pagar(10,2)),
	asserta(pagar(10,3)),
	asserta(pagar(10,4)),
	asserta(pagar(11,4)),
	asserta(pagar(10,6)),
	asserta(pagar(11,6)),
	asserta(pagar(10,7)),
	asserta(pagar(10,8)),
	asserta(pagar(10,9)),
	asserta(pagar(10,10)),
	asserta(pagar(11,10)),
	asserta(pagar(12,10)),
	asserta(pagar(13,10)),
	asserta(pagar(14,10)),
	asserta(pagar(15,10)),
	asserta(pagar(10,11)),
	asserta(pagar(10,12)),
	asserta(pagar(10,13)),
	asserta(pagar(10,14)),
	asserta(pagar(11,14)),
	!.

borderatas(_,Y) :-
	Y =:= 0,!.

borderbawah(_,Y) :-
	tinggipeta(T),
	Ymax is T+1,
	Y =:= Ymax,!.

borderkiri(X,_) :-
	X =:= 0,!.

borderkanan(X,_) :-
	lebarpeta(L),
	Xmax is L+1,
	X =:= Xmax,!.

printpeta(X,Y) :-
	borderatas(X,Y), !, write('#').
printpeta(X,Y) :-
	borderbawah(X,Y), !, write('#').
printpeta(X,Y) :-
	borderkiri(X,Y), !, write('#').
printpeta(X,Y) :-
	borderkanan(X,Y), !, write('#').
printpeta(X,Y) :-
	player(X,Y), !, write('P').
printpeta(X,Y) :-
	store(X,Y), !, write('S').
printpeta(X,Y) :-
	quest(X,Y), !, write('Q').
printpeta(X,Y) :-
	dungeon(X,Y), !, write('D').
printpeta(X,Y) :-
	pagar(X,Y), !, write('#').
printpeta(_,_) :-
	write('-').

map:-
	tinggipeta(T),
	lebarpeta(L),
	X is 0,
	Xmax is L+1,
	Y is 0,
	Ymax is T+1,
	forall(between(Y, Ymax, J), (
		forall(between(X, Xmax, I), (
			printpeta(I,J)
		)),
		nl
	)),
	write('Keterangan : '),
	nl,
	write('    P = Player'),
	nl,
	write('    S = Store'),
	nl,
	write('    Q = Quest'),
	nl,
	write('    D = Dungeon Boss'),
	nl,
	!.


% move
w :-
	inbattle(_,_,1),
	write('Finish your battle first!!'),!.
w :-
	player(_,Y),
	Y =:= 1,
	write('Oops! You just collided with a barrier! Try moving another direction.'),nl,!.
w :-
	player(X,Y),
	pagar(X,P),
	Q is P+1,
	Y =:= Q,
	write('Oops! You just collided with a barrier! Try moving another direction.'),nl,!.
w :- 
	retract(player(X,Y)),
	Y > 1,
	NewY is Y - 1,
	write('You move north'), nl,
	asserta(player(X, NewY)), appear,
	!.

a :-
	inbattle(_,_,1),
	write('Finish your battle first!!'),!.

a :-
	player(X,_),
	X =:= 1,
	write('Oops! You just collided with a barrier! Try moving another direction.'),nl,!.
a :-
	player(X,Y),
	pagar(P,Y),
	Q is P+1,
	X =:= Q,
	write('Oops! You just collided with a barrier! Try moving another direction.'),nl,!.
a :- 
	retract(player(X,Y)),
	NewX is X - 1,
	write('You move west'), nl,
	asserta(player(NewX, Y)), appear, 
	!.

s :-
	inbattle(_,_,1),
	write('Finish your battle first!!'),!.
s :-
	player(_,Y),
	tinggipeta(P),
	Y =:= P,
	write('Oops! You just collided with a barrier! Try moving another direction.'),nl,!.
s :-
	player(X,Y),
	pagar(X,P),
	Q is P-1,
	Y =:= Q,
	write('Oops! You just collided with a barrier! Try moving another direction.'),nl,!.
s :- 
	retract(player(X,Y)),
	NewY is Y + 1,
	write('You move South!'), nl,
	asserta(player(X, NewY)),  appear, 
	!.

d :-
	inbattle(_,_,1),
	write('Finish your battle first!!'),!.
d :-
	player(X,_),
	lebarpeta(Q),
	X =:= Q,
	write('Oops! You just collided with a barrier! Try moving another direction.'),nl,!.
d :-
	player(X,Y),
	pagar(P,Y),
	Q is P-1,
	X =:= Q,
	write('Oops! You just collided with a barrier! Try moving another direction.'),nl,!.
d :- 
	retract(player(X,Y)),
	NewX is X + 1,
	write('You moved east!'), nl,
	asserta(player(NewX, Y)), appear,
	!.

appear :-
	random(1,7,Appear),
	(Appear =:= 5 -> 
		takeaquest(1),
		write('You found an enemy!!!'),
		asserta(enemyappear(1)),
		startbattle;
		nothing).

nothing :-
	player(X,Y),
	store(X,Y),
	write('You are on the Store'), nl,nl,
	write('To access store, use command "shop."'), nl,nl, !.

nothing :-
	\+takeaquest(1),
	player(X,Y),
	quest(X,Y),
	write('You are on the Quest Office'), nl,nl,
	asserta(takeaquest(1)),
	take_q,!.
	
nothing :-
	takeaquest(1),
	player(X,Y),
	quest(X,Y),
	write('You have taken a quest!'), nl,nl,
	!.
	
nothing :-
	player(X,Y),
	dungeon(X,Y),
	write('You are on the Dungeon Boss'), nl,nl,
	asserta(bossappear(1)),
	startbattle,!.
	
nothing :-
	write('There is nothing in here'), nl,nl.
