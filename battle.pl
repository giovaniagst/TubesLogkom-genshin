initiateBattle :-
    inbattle(_,Player,1). /*Ini kondisinya kalo emang udah ada musuh, dianggep inbattle*/
    /*Kalo misal belakangnya 1, artinya lagi dalam battle*/
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
    enemy_status(Name,Health,XP).
    write(Name),nl,
    write(Health),nl,
    write(Exp),nl.

/*Variabel, ngikutin enemy.pl*/
enemy_status(Name,Health,Exp).

/*Variabel*/
player_status(Name,Health,Exp).

display_player_status :-
    /*Bikin state player di sini*/
    player_status(Name,Health,Exp),
    write(Name),nl,
    write(Health),nl,
    write(Exp),nl.

use_potion :-
	check_amount_of_potion(X), /*Asumsi udah didefinisiin*/
	X=0, /*Gaada potion*/
	write('No potion to use.'),!.

use_potion :-
	check_amount_of_potion(X), /*Asumsi udah didefinisiin*/
	X/=0,
	retract(player_status(Name,Health,Exp)),
	potion(PotionName, AddHealth), /*Asumsinya semua potion di-state menambah health berapa*/
	NewHealth is Health+AddHealth,
	assert(player_status(Name,Health,Exp)),
	write('Yay, your health improved by', ).

/*Hubungan potionnya ntar sama yang disimpen*/

attack :-
	inbattle(_,Player,0), %Kalo misal ga lagi dalam pertarungan
	write('Command cannot be used because you are not in a battle.'),nl,!.

attack :-
    inbattle(_,Player,1),
    /*Berdasarkan inventory*/
    write('Damage!!!'),
    retract(player_status(Name,Health,Exp)),
    NewHealth is Health-Damage,
    NewXP is XP-Damage, /*Masih ngasal banget yang pengurangannya*/
    assert(player_status(Name,Health,Exp)).

useInventory :-
	check_amount_of_inventory(X),
	X=0, /*Gaada inventory*/
	write('No inventory to use.'),!.
	
useInventory :-
	check_amount_of_inventory(X),
	X/=0,
	chooseInventory.

chooseInventory :-
	/*Gatau belum ngerti cara milih barang di inventory*/

special_attack:
    /*Sama kayak attack, tapi damagenya lebih gede*/

win:-
    checkwin,
    retract(inbattle(_,Player,1),
    write('YOU WON!'),nl,
    assert(inbattle(_,Player,0). /*Dibikin jadi 0 artinya dia keluar dari battle*/
    /*write....*/

lose :-
    checklose(IDName).
    write('YOU LOSEEEEEEE!'),nl.
    /*write...*/

checklose:-
    statePlayer(IDName,0,_).

checkwin :-
    stateEnemy(BossEnemy,0,_).

enemy_attack:-

enemy_specialattack:-

run :-
    randInterval(0,1,X).
    X = 1, runsuccess,!.
    X = 0, runfail,!.

runfail:-
    write('Bad luck! You are not able to run~').

runsuccess:-
    retract(inbattle(_,Player,1),
    write('You successfully run from the enemy.'),
    assert(inbattle(_,Player,0). /*Dibikin jadi 0 artinya dia keluar dari battle*/

/*Inget selalu dicek lagi inBattle apa ngga*/
/*Cek yang boss enemy, kalo udah selesai ya menang*/
/*Ada bagian turn musuh*/
/*Ngecek enemy dead*/
/*Damagenya berdasarkan inventory*/

/*---------------------------------*/
/* Buat variables */

/*inBattle(Enemy,Player)*/
/*stateEnemy(Enemy,XP,Health)*/
/*statePlayer(Name,XP,Health)*/
