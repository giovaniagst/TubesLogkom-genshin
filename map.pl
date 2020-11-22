/* :- include('battle.pl'). */

:- dynamic(lebar/1).
:- dynamic(tinggi/1).
:- dynamic(pagar/2).
:- dynamic(playing/1).
:- dynamic(quest/2).
:- dynamic(store/2).
:- dynamic(enemy/2).


lebar(15).
tinggi(15).

mulai :-
	
	asserta(store(13,9)),
	asserta(dungeon(13,13)),
	asserta(quest(13,2)),
	asserta(player(1,1)),
	/* space buat forall blabla krn masih gapaham */
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
	
/* untuk print map */
pagaratas(_,Y) :-
	Y =:= 0,!.
	
pagarbawah(_,Y) :-
	tinggi(T),
	Y =:= T+1, !.
	
pagarkiri(X,_) :-
	X =:= 0,!.
	
pagarkanan(X,_) :-
	lebar(L),
	X =:= L+1, !.
	
printmap(X,Y) :-
	pagaratas(X,Y),
	!,
	write('#').
printmap(X,Y) :-
	pagarkiri(X,Y),
	!,
	write('#').
printmap(X,Y) :-
	pagarkanan(X,Y),
	!,
	write('#').
printmap(X,Y) :-
	pagarbawah(X,Y),
	!,
	write('#').	
printmap(X,Y) :-
	player(X,Y),
	!,
	write('P').
printmap(X,Y) :-
	store(X,Y),
	!,
	write('S').
printmap(X,Y) :-
	dungeon(X,Y),
	!,
	write('D').
printmap(X,Y) :-
	quest(X,Y),
	!,
	write('Q').
printmap(X,Y) :-
	pagar(X,Y),
	!,
	write('#').
printmap(_,_) :-
	write('#').
	
/* penggunaan command "map." */
map :-
	\+playing(_),
	write('You need to type "start." first before using map.'),
	nl,
	!.
map :-
	tinggi(T),
	lebar(L),
	X is 0,
	Y is 0,
	forall(between(Y, L+1, J), (
		forall(between(X, T+1, I), (
			printmap(I,J)
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

/* jika player sampai ke suatu titik */
arrive :-
	player(X,Y),
	quest(X,Y),
	write('Arrived at the Quest Office!'),
	nl,
	write('You can take quests here to get additional bonus for killing enemies!'),
	nl,
	!.

arrive :-
	player(X,Y),
	store(X,Y),
	write('Arrived at the Store!'),
	nl,
	write('You can buy equipments using golds!'),
	nl,
	!.

arrive :-
	player(X,Y),
	dungeon(X,Y),
	write('Arrived at the Dungeon Boss!'),
	nl,
	write('Ssh! A dragon is sleeping here!'),
	nl,
	!.

arrive :-
	write('Nothing in here.'),
	nl,
	write('Keep walking adventurer!'),
	nl,
	!.

found :-
	random(0,5,Found),
	/* decide sbg rule masuk ke battle mechanism */
	(Found =:= 1 -> decide; arrive).
	
/* command perpindahan player */
w :-
	\+playing(_), /* pastiin  sama rulesnya kyk main.pl */
	write('You need to type "start." first before using map.'),
	nl,
	!.
w :-
	\+selected, /* pastiin sama rulesnya kyk player.pl */
	write('Choose your job first before starting your adventure!'),
	nl,
	!.
w :-
	inbattle(_), 
	write('Finish your battle first!'),
	nl,
	!.
w :-
	selected,
	player(_,Y),
	Y =:= 1,
	write('Oops! Collided with a barrier! Try moving to another direction!'),
	nl,
	!.
w :-
	selected,
	player(X,Y),
	pagar(X,P),
	Y =:= P+1,
	write('Oops! Collided with a barrier! Try moving to another direction!'),
	nl,
	!.
/* w :-
	selected,
	pilih(1),
	write('You have found an enemy!'),
	nl,
	% rule generate random enemy
	% rule masuk ke battle mechanism,
	!. */
w :-
	selected, 
	retract(player(X,Y)),
	Y > 1,
	NewY is Y-1,
	asserta(player(X,NewY)),
	write('You walked north'),
	nl,
	found, % sama kyk appear wkwkw
	!.

a :-
	\+playing(_), /* pastiin  sama rulesnya kyk main.pl */
	write('You need to type "start." first before using map.'),
	nl,
	!.
a :-
	\+selected, /* pastiin sama rulesnya kyk player.pl */
	write('Choose your job first before starting your adventure!'),
	nl,
	!.
a :-
	inbattle(_), 
	write('Finish your battle first!'),
	nl,
	!.
a :-
	selected,
	player(X,_),
	X =:= 1,
	write('Oops! Collided with a barrier! Try moving to another direction!'),
	nl,
	!.
a :-
	selected,
	player(X,Y),
	pagar(P,Y),
	X =:= P+1,
	write('Oops! Collided with a barrier! Try moving to another direction!'),
	nl,
	!.
/* a :-
	selected,
	pilih(1),
	write('You have found an enemy!'),
	nl,
	% rule generate random enemy
	% rule masuk ke battle mechanism,
	!. */
a :-
	selected, 
	retract(player(X,Y)),
	NewX is X-1,
	asserta(player(NewX,Y)),
	write('You walked west'),
	nl,
	found, % sama kyk appear wkwkw
	!.

s :-
	\+playing(_), /* pastiin  sama rulesnya kyk main.pl */
	write('You need to type "start." first before using map.'),
	nl,
	!.
s :-
	\+selected, /* pastiin sama rulesnya kyk player.pl */
	write('Choose your job first before starting your adventure!'),
	nl,
	!.
s :-
	inbattle(_), 
	write('Finish your battle first!'),
	nl,
	!.
s :-
	selected,
	player(_,Y),
	tinggi(P),
	Y =:= P,
	write('Oops! Collided with a barrier! Try moving to another direction!'),
	nl,
	!.
s :-
	selected,
	player(X,Y),
	pagar(X,P),
	Y =:= P-1,
	write('Oops! Collided with a barrier! Try moving to another direction!'),
	nl,
	!.
/* s :-
	selected,
	pilih(1),
	write('You have found an enemy!'),
	nl,
	% rule generate random enemy
	% rule masuk ke battle mechanism,
	!. */
s :-
	selected, 
	retract(player(X,Y)),
	NewY is Y+1,
	asserta(player(X,NewY)),
	write('You walked south'),
	nl,
	found, % sama kyk appear wkwkw
	!.

d :-
	\+playing(_), /* pastiin  sama rulesnya kyk main.pl */
	write('You need to type "start." first before using map.'),
	nl,
	!.
d :-
	\+selected, /* pastiin sama rulesnya kyk player.pl */
	write('Choose your job first before starting your adventure!'),
	nl,
	!.
d :-
	inbattle(_), 
	write('Finish your battle first!'),
	nl,
	!.
d :-
	selected,
	player(X,_),
	lebar(P);
	X =:= P,
	write('Oops! Collided with a barrier! Try moving to another direction!'),
	nl,
	!.
d :-
	selected,
	player(X,Y),
	pagar(P,Y),
	X =:= P-1,
	write('Oops! Collided with a barrier! Try moving to another direction!'),
	nl,
	!.
/* d :-
	selected,
	pilih(1),
	write('You have found an enemy!'),
	nl,
	% rule generate random enemy
	% rule masuk ke battle mechanism,
	!. */
d :-
	selected, 
	retract(player(X,Y)),
	NewX is X+1,
	asserta(player(NewX,Y)),
	write('You walked east'),
	nl,
	found, % sama kyk appear wkwkw
	!.