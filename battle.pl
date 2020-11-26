:- include('inventory.pl').
:- include('enemy.pl').
:- include('player.pl').
:- dynamic(amountofenemy/1).
:- dynamic(inbattle/3).
:- dynamic(player_status/3).
:- dynamic(playerturn/1).
:- dynamic(enemyfound/1).

startbattle :-
	write('Choose start(X), with X being swordman/archer/sorcherer.'),nl. /*Belum dihubungin sama yang lain*/
    
start(X):- /*Ini buat back-up sebelum nanti dihubungin sama file lain*/
	X=swordman,
	inventory_swordman,
	swordman,
	health(Hea),
	attack(Att),
	defense(Def),
	asserta(player_status(Hea,Att,Def)),
	write('You found yourself a'),nl,
	random_enemy,nl,
	enemyfound.

start(X):-
	X=archer,
	inventory_archer,
	archer,
	health(Hea),
	attack(Att),
	defense(Def),
	asserta(player_status(Hea,Att,Def)),
	write('You found yourself a'),nl,
	random_enemy,nl,
	enemyfound.

start(X):-
	X=sorcerer,
	inventory_sorcerer,
	sorcerer,
	health(Hea),
	attack(Att),
	defense(Def),
    	asserta(player_status(Hea,Att,Def)),
	inventory_sorcerer,
	write('You found yourself a'),nl,
	random_enemy,nl,
	enemyfound.

enemyfound:-
	asserta(amountofenemy(1)),
	write('Fight like a knight, or run like a coward. Your choice.'),nl,
	write('Choose.'), nl,
	write('- startfight.'), nl,
	write('- run.'), nl.

run :-
    random(0,1,X),
    runluck(X).

runluck(X):-
    X = 1,
    retract(amountofenemy(_)),
    retract(enemy(_,_,_,_,_)),
    write('You successfully run from the enemy.'),
    asserta(amountofenemy(0)),!.

runluck(X):-
    X = 0,
    write('Bad luck! You are not able to run~'),
    startfight.

use_potion:-
	retract(player_status(Hea,Att,Def)),
	haveH(health_potion,_,AddHea),
	delFromInventory(health_potion),
	NewHea is (Hea+AddHea),
	asserta(player_status(NewHea,Att,Def)),
	write('Your health improved by '),
	write(AddHea),nl,
	fight.

startfight :-
    asserta(inbattle(_,_,1)),
    asserta(playerturn(1)),
	write('List of things you are able to do:'),nl,
	write('- attack.'),nl,
	write('- special_attack.'),nl,
	write('- use_potion.'),nl.

fight :-
    inbattle(_,_,1),
    playerturn(1),
	write('List of things you are able to do:'),nl,
	write('- attack.'),nl,
	write('- special_attack.'),nl,
	write('- use_potion.'),nl.

attack :-
	inbattle(_,_,0), /*Kalo misal ga lagi dalam pertarungan*/
	write('Command cannot be used because you are not in a battle.'),nl,!.

attack :-
    inbattle(_,_,1),
    playerturn(1),
    showinventory.
    
use(W) :-
    haveE(W,_,Damage),
    write('Damage!!!'),nl,
    retract(enemy(_,_,Hea,_,_)),
    NewHea is (Hea-Damage),
    asserta(enemy(_,_,NewHea,_,_)),
    check_enemydead.

showinventory:-
	forall(haveE(Weapon,_,_),(write(Weapon),nl)),
	write('Choose by writing use(weaponname)'),nl.
	
special_attack :-
    inbattle(_,_,1),
    playerturn(1),
    random(0,3,X),
    specialattack_able(X).

specialattack_able(X):-
    X=0,    
    write('Damage!!!'),nl,
    retract(enemy(_,_,Hea,_,_)),
    random(1700,2000,Dmg),
    NewHea is (Hea-Dmg),
    asserta(enemy(_,_,NewHea,_,_)),
    check_enemydead.

specialattack_able(X):-
    X\=0,
    write('Sorryyy, you are not able to use this now, choose other options.'),nl,
    write('- attack.'),nl,
    write('- use_potion.').

enemyattack :-
    inbattle(_,_,1),
    playerturn(0),
    retract(player_status(Hea,Att,Def)),
    random(1300,1500,Dmg),
    NewHea is (Hea-Dmg),
    asserta(player_status(NewHea,Att,Def)),
    write('You are damaged!'),nl,
    check_enemydead.

check_enemydead :-
	enemy(_,_,Hea,_,_),
	Hea =< 0,
	retract(inbattle(_,_,_)),
	asserta(inbattle(_,_,0)),
	write('The enemy has fallen.'),nl,!.

check_enemydead :-
	enemy(_,_,Hea,_,_),
	Hea > 0,
	check_playerdead,!.

check_playerdead :-
	player_status(Hea,_,_),
	Hea =< 0,
	retract(inbattle(_,_,_)),
	asserta(inbattle(_,_,0)),
	write('YOU DIED.'),nl,!.

check_playerdead :-
    player_status(Hea,_,_),
	Hea > 0,
	whichTurn,!.

whichTurn :-
	playerturn(1),
	retract(playerturn(1)),
	asserta(playerturn(0)),
	write('Its your enemys turn!'),nl,
	enemyattack.

whichTurn :-
	playerturn(0),
	retract(playerturn(0)), 
	asserta(playerturn(1)),
	write('Your turn!'),nl,
	fight.

    /*Random buat defense-nya*/
