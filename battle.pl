initiateBattle :-
    inBattle(Enemy,Player). /*Kayak dibikin jadi true(?)*/
    % Ceritanya ada musuh yang muncul
	write('List of things you are able to do:'),nl,
	write('- attack.'),nl,
	write('- special_attack.'),nl,
	write('- use_potion.'),nl,
	write('- run.'),nl,
	write('- display_enemy_status.'),nl,
	write('- display_player_status.'),nl.

display_enemy_status :-
    /*Kita display kayak state enemy di sini*/
    enemy_status(name,health,XP).
    write(name),nl,
    write(health),nl,
    write(exp),nl.

/*Variabel*/
enemy_status(name,health,XP).

/*Variabel*/
player_status(name,health,XP).

display_player_status :-
    /*Bikin state player di sini*/
    player_status(name,health,XP),
    write(name),nl,
    write(health),nl,
    write(exp),nl.

use_potion :-
	check_amount_of_potion(X),
	X=0, /*Gaada potion*/
	write('No potion to use.').

use_potion :-
	check_amount_of_potion(X), /*Asumsi udah didefinisiin*/
	X/=0,
	retract(statePlayer(Name,XP,Health)),
	potion(PotionName, AddHealth), /*Asumsinya semua potion di-state menambah health berapa*/
	NewHealth is Health+AddHealth,
	assert(statePlayer(Name,XP,Health)),
	write('Yay, your health improved by', ).

/*Hubungan potionnya ntar sama yang disimpen*/

attack :-
	\+inbattle(), %Kalo misal ga lagi dalam pertarungan
	write('Command cannot be used because you are not in a battle.'),nl,!.

attack :-
    inbattle(_,Player,_,_),
    /*Definisin attacknya satu2, ada damagenya*/
    /*Atau dirandom aja damagenya*/
    /*Berdasarkan inventory*/
    write('Damage!!!')
    retract(statePlayer(Name,XP,Health)).
    Health is Health-Damage,
    XP is XP-Damage, /*Masih ngasal banget yang pengurangannya*/
    assert(statePlayer(Name,XP,Health)).

special_attack:
    /*Sama kayak attack, tapi damagenya lebih gede*/

win:-
    checklose(BossEnemy),
    write('YOU WON!'),nl,
    /*write....*/

lose :-
    checklose(Player).
    write('YOU LOSEEEEEEE!'),nl.
    /*write...*/

checklose(Name):-
    statePlayer(Name,0,Health).

modify(Name):-
    retract(statePlayer(Name,_,_).
    XP is XP*(),
    Health is Health+(),
    assert(statePlayer(Name,XP,Health)).

check_boss_enemy:-
    stateEnemy(BossEnemy,_,_).

enemy_attack:-

enemy_specialattack:-

run :-
    randInterval(0,1,X).
    X = 1, runsuccess,!.
    X = 0, runfail,!.

runfail:-
    write('Bad luck! You are not able to run~').

runsuccess:-
    write('You successfully run from the enemy.')

/*Inget selalu dicek lagi inBattle apa ngga*/
/*Cek yang boss enemy, kalo udah selesai ya menang*/
/*Dirandom runnya bisa atau ngga*/
/*Bisa jadi bikin fungsi baru untuk ngemodify-health sama damage-nya*/
/*Pemanfaatan inventorynya gimana*/
/*Ada bagian turn musuh*/
/*Ngecek enemy dead*/
/*Damagenya berdasarkan inventory*/

/*---------------------------------*/
/* Buat variables */

/*inBattle(Enemy,Player)*/
/*stateEnemy(Enemy,XP,Health)*/
/*statePlayer(Name,XP,Health)*/