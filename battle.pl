:- dynamic(amountofenemy/1).
:- dynamic(inbattle/3).
:- dynamic(enemy_status/3).
:- dynamic(player_status/3).
:- dynamic(playerturn/1).
:- dynamic(enemyfound/1).

start:- /*Ini buat back-up sebelum nanti dihubungin sama file lain*/
	asserta(player_status(id,3000,3000)),
	enemyfound(someone).

enemyfound(EnemyName):-
	asserta(amountofenemy(1)),
	asserta(enemy_status(EnemyName,4000,3000)),
	write('Fight like a knight, or run like a coward. Your choice.'),nl,
	write('Choose.'), nl,
	write('- fight.'), nl,
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
    fight.

fight :-
    asserta(inbattle(_,_,1)),
    asserta(playerturn(1)),
	write('List of things you are able to do:'),nl,
	write('- attack.'),nl,
	write('- special_attack.'),nl,
	write('- use_potion.'),nl.

attack :-
	inbattle(_,_,0), /*Kalo misal ga lagi dalam pertarungan*/
	write('Command cannot be used because you are not in a battle.'),nl,!.
	
attack :-
   inbattle(_,_,1),
   playerturn(0),
   write('Not your turn yet!!'),!.

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

enemyattack :-
    retract(player_status(Name,Health,Exp)),
    random(1300,1500,Dmg),
    NewHealth is Health-Dmg,
    NewExp is Exp-Dmg,
    asserta(player_status(Name,NewHealth,NewExp)),
    check_enemydead.

check_enemydead :-
	enemy_status(_,Health,_),
	Health =< 0,
	write('The enemy has fallen.'),!.

check_enemydead :-
	enemy_status(_,Health,_),
	Health > 0,
	check_playerdead.

check_playerdead :-
	player_status(_,Health,_),
	Health =< 0,
	write('YOU DIED.'),!.

check_playerdead :-
	player_status(_,Health,_),
	Health > 0,
	whichTurn.

whichTurn :- /*Bisa aja yang enemy yang mau attack*/
	random(0,3,X),
        decide(X).

decide(X) :-
	X=3,
	retract(playerturn(_)),
	asserta(playerturn(0)),
	write('Its your enemys turn!'),
	enemyattack.

decide(X) :-
	X \= 3, 
	retract(playerturn(_)), 
	asserta(playerturn(1)),
	write('Your turn!'),
	fight.


/* ##################################### */

/* ATAS MASIH BUG */

/* INI BAWAH BELUMMMMM */

/* SPECIAL ATTACK JUGA BELUM */

/* DAMAGE BERDASARKAN INVENTORY BUKAN RANDOM */

/* Perlevelan gimana ya */

/* Kayaknya ntar bakal pake halt di akhir */

/* Mau cari tau arti reset apaan */

% use_potion :-
%	check_amount_of_potion(X), /*Asumsi udah didefinisiin*/
%	X=0, /*Gaada potion*/
%	write('No potion to use.'),!.

% use_potion :-
%	check_amount_of_potion(X),
%	X/=0,
%	player_status(Name,Health,Exp),
%	Health==MaxHealth, /*Istilahnya udah ga bisa nambah lagi healthnya(?), ga penting sih*/
%	write('You're fully healthy~ what is potion for?').

% use_potion :-
%	check_amount_of_potion(X), /*Asumsi udah didefinisiin*/
%	X/=0,
%	player_status(Name,Health,Exp),
%	Health/=MaxHealth,
%	retract(player_status(Name,Health,Exp)),
%	potion(PotionName, AddHealth), /*Asumsinya semua potion di-state menambah health berapa*/
%	NewHealth is Health+AddHealth,
%	assert(player_status(Name,NewHealth,Exp)),
%	write('Yay, your health improved by', ).
%
% /*Hubungan potionnya ntar sama yang disimpen*/

% useInventory :-
%	check_amount_of_inventory(X),
%	X==0, /*Gaada inventory*/
%	write('No inventory to use.'),!.
%	
% useInventory :-
%	check_amount_of_inventory(X),
%	X/=0,
%	chooseInventory.
%
% chooseInventory :-
%	/*Gatau belum ngerti cara milih barang di inventory*/
%
% win:-
%    checkwin,
%    retract(inbattle(_,Player,1),
%    write('YOU WON!'),nl,
%    assert(inbattle(_,Player,0). /*Dibikin jadi 0 artinya dia keluar dari battle*/
%    /*write....*/
%
% lose :-
%    checklose(IDName).
%    write('YOU LOSEEEEEEE!'),nl.
%    /*write...*/
