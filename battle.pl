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
  
start(X):-
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
	haveH(health_potion,_,AddHea),
	retract(player_status(Hea,Att,Def)),
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
	write('- use_potion(health_potion).'),nl.

fight :-
    inbattle(_,_,1),
    playerturn(1),
	write('List of things you are able to do:'),nl,
	write('- attack.'),nl,
	write('- special_attack.'),nl,
	write('- use_potion(health_potion).'),nl.

attack :-
	inbattle(_,_,0), /*Kalo misal ga lagi dalam pertarungan*/
	write('Command cannot be used because you are not in a battle.'),nl,!.

attack :-
    inbattle(_,_,1),
    playerturn(1),
    write('> justattack. --- to proceed without equipments,'),nl,
    write('> showinventory. --- if you want to use some to add your attack.'),nl.

justattack :-
    retract(enemy(Name,_,Hea,_,Def)),
    random(30,50,Dmg),
    write(Dmg),
    write(' damage hits '),
    write(Name),nl,  
    random(0,30,Y),
    write('Nevertheless, '),
    write(Name),nl,
    write(' used his '),
    write(Y),
    write(' defense'),nl,
    NewHea is (Hea-Dmg+0.5*Y),
    NewDef is (Def-Y),
    asserta(enemy(Name,_,NewHea,_,NewDef)),
    retract(player_status(Hea,A,_)),
    NewA is (A-Dmg),
    asserta(player_status(Hea,NewA,_)),
    check_enemydead,
    whichTurn,!.

use(W) :-
    retract(enemy(Name,_,Hea,_,Def)),
    random(30,50,Dmg1),
    write(Dmg1),
    haveE(W,_,Dmg),
    write(Dmg),
    write(Dmg1+Dmg),
    write(' damage hits '),
    write(Name),nl,  
    random(0,30,Y),
    write('Nevertheless, '),
    write(Name),nl,
    write(' used his '),
    write(Y),
    write(' defense'),nl,
    NewHea is (Hea-Dmg1-Dmg+0.5*Y),
    NewDef is (Def-Y),
    asserta(enemy(Name,_,NewHea,_,NewDef)),
    retract(player_status(Hea,A,_)),
    NewA is (A-Dmg1),
    asserta(player_status(Hea,NewA,_)),
    check_enemydead,
    whichTurn,!.

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
    retract(enemy(Name,_,Hea,_,Def)),
    random(100,200,Dmg),
    write(Dmg),
    write(' damage hits '),
    write(Name),nl,  
    random(0,30,Y),
    write('Nevertheless, '),
    write(Name),nl,
    write(' used his '),
    write(Y),
    write(' defense'),nl,
    NewHea is (Hea-Dmg+0.5*Y),
    NewDef is (Def-Y),
    asserta(enemy(Name,_,NewHea,_,NewDef)),
    check_enemydead,
    whichTurn,!.

specialattack_able(X):-
    X\=0,
    write('Sorryyy, you are not able to use this now, choose other options.'),nl,
    write('- attack.'),nl,
    write('- use_potion.').

enemyattack :-
    inbattle(_,_,1),
    playerturn(0),
    retract(player_status(Hea,Att,Def)),
    random(100,150,Dmg),
    write(Dmg),
    write(' damage hits you'),nl,
    random(0,30,Y),
    write('Nevertheless, you used your '),
    write(Y),
    write(' defense'),nl,
    NewHea is (Hea-Dmg+0.5*Y),
    NewDef is (Def-Y),
    asserta(player_status(NewHea,Att,NewDef)),
    check_enemydead,
    whichTurn,!.

check_enemydead :-
	enemy(_,_,Hea,_,_),
	Hea =< 0,
	retract(inbattle(_,_,_)),
	asserta(inbattle(_,_,0)),
	write('The enemy has fallen.').

check_enemydead :-
	enemy(_,_,Hea,_,_),
	Hea > 0,
	check_playerdead,!.

check_playerdead :-
	player_status(Hea,_,_),
	Hea =< 0,
	retract(inbattle(_,_,_)),
	asserta(inbattle(_,_,0)),
	write('YOU DIED.').

check_playerdead :-
    player_status(Hea,_,_),
    Hea > 0.

whichTurn :-
	inbattle(_,_,1),
	playerturn(0),
	retract(playerturn(0)), 
	asserta(playerturn(1)),
	write('Your turn!'),nl,
	fight,!.

whichTurn :-
	inbattle(_,_,1),
	playerturn(1),
	retract(playerturn(_)),
	asserta(playerturn(0)),
	write('Its your enemys turn!'),nl,
	enemyattack.

whichTurn :-
	inbattle(_,_,0).
