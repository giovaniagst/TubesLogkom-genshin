:- dynamic(amountofenemy/1).
:- dynamic(inbattle/3).
:- dynamic(enemy_status/3).
:- dynamic(player_status/3).
:- dynamic(playerturn/1).
:- dynamic(enemyfound/1).

start:- /*Ini buat back-up sebelum nanti dihubungin sama file lain*/
	asserta(player_status(id,10000,50000)),
	enemyfound(someone).

enemyfound(EnemyName):-
	asserta(amountofenemy(1)),
	asserta(enemy_status(EnemyName,8000,10000)),
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
    retract(enemy_status(_,_,_)),
    write('You successfully run from the enemy.'),
    asserta(amountofenemy(0)),!.

runluck(X):-
    X = 0,
    write('Bad luck! You are not able to run~'),
    startfight.

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
    write('Damage!!!'),
    retract(enemy_status(Name,Health,Exp)),
    random(1300,1500,Dmg),
    NewHealth is Health-Dmg,
    NewExp is Exp-Dmg,
    asserta(enemy_status(Name,NewHealth,NewExp)),
    check_enemydead.

specialattack :-
    inbattle(_,_,1),
    playerturn(1),
    write('Damage!!!'),nl,
    retract(enemy_status(Name,Health,Exp)),
    random(1700,2000,Dmg),
    NewHealth is Health-Dmg,
    NewExp is Exp-Dmg,
    asserta(enemy_status(Name,NewHealth,NewExp)),
    check_enemydead.

enemyattack :-
    inbattle(_,_,1),
    playerturn(0),
    retract(player_status(Name,Health,Exp)),
    random(1300,1500,Dmg),
    NewHealth is Health-Dmg,
    NewExp is Exp-Dmg,
    asserta(player_status(Name,NewHealth,NewExp)),
    write('You are damaged!'),nl,
    check_enemydead.

check_enemydead :-
	enemy_status(_,Health,_),
	Health =< 0,
	write('The enemy has fallen.'),nl,!.

check_enemydead :-
	enemy_status(_,Health,_),
	Health > 0,
	check_playerdead,!.

check_playerdead :-
	player_status(_,Health,_),
	Health =< 0,
	write('YOU DIED.'),nl,!.

check_playerdead :-
	player_status(_,Health,_),
	Health > 0,
	whichTurn,!.

whichTurn :- /*Bisa aja yang enemy yang mau attack*/
        write('Wait for your luck...'),nl,
	write('...'),nl,
	write('...'),nl,
	write('...'),nl,
	random(0,2,X),
        decide(X).

decide(X) :-
	X=0,
	retract(playerturn(_)),
	asserta(playerturn(0)),
	write('Its your enemys turn!'),nl,
	enemyattack.

decide(X) :-
	X\=0, 
	retract(playerturn(_)), 
	asserta(playerturn(1)),
	write('Your turn!'),nl,
	fight.
