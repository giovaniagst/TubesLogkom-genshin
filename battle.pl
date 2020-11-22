enemyFound(EnemyName) :-
	retract(amountofenemy(0)),
	assert(amountofenemy(1)),
	assert(enemy_status(Name,Health,Exp)). /*Gatau deh pokoknya kayak nyetel enemy yang ada*/
	write('Fight like a knight, or run like a coward. Your choice.'),nl.
	write('Choose.'),
	write('- fight.'), nl,
	write('- run.'), nl.

fight :-
    inbattle(_,Player,1),
    assert(playerturn(1)). /*Dikasih kesempatan lebih duluan player*/
    assert(enemyturn(0)).
    /*Kalo misal belakangnya 1, artinya lagi dalam battle*/
	write('List of things you are able to do:'),nl,
	write('- attack.'),nl,
	write('- special_attack.'),nl,
	write('- use_potion.'),nl,
	write('- display_enemy_status.'),nl,
	write('- display_player_status.'),nl.

display_enemy_status :-
    /*Kita display kayak state enemy di sini*/
    enemy_status(Name,Health,XP).
    write(Name),nl,
    write(Health),nl,
    write(Exp),nl.

/*Variabel, ngikutin enemy.pl ntar*/
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
	check_amount_of_potion(X),
	X/=0,
	player_status(Name,Health,Exp),
	Health==MaxHealth, /*Istilahnya udah ga bisa nambah lagi healthnya(?), ga penting sih*/
	write('You're fully healthy~ what is potion for?').

use_potion :-
	check_amount_of_potion(X), /*Asumsi udah didefinisiin*/
	X/=0,
	player_status(Name,Health,Exp),
	Health/=MaxHealth,
	retract(player_status(Name,Health,Exp)),
	potion(PotionName, AddHealth), /*Asumsinya semua potion di-state menambah health berapa*/
	NewHealth is Health+AddHealth,
	assert(player_status(Name,NewHealth,Exp)),
	write('Yay, your health improved by', ).

/*Hubungan potionnya ntar sama yang disimpen*/

attack :-
	inbattle(_,Player,0), /*Kalo misal ga lagi dalam pertarungan
	write('Command cannot be used because you are not in a battle.'),nl,!.
	
attack :-
   inbattle(_,Player,1),
   playerturn(0),
   write('Not your turn yet!!'),!.

attack :-
    inbattle(_,Player,1),
    playerturn(1),
    /*Berdasarkan inventory*/
    write('Damage!!!'),
    retract(enemy_status(Name,Health,Exp)),
    NewHealth is Health-Damage,
    NewExp is Exp-Damage, /*Masih ngasal banget yang pengurangannya*/
    assert(enemy_status(Name,NewHealth,NewExp)).
    whichTurn.

useInventory :-
	check_amount_of_inventory(X),
	X==0, /*Gaada inventory*/
	write('No inventory to use.'),!.
	
useInventory :-
	check_amount_of_inventory(X),
	X/=0,
	chooseInventory.

chooseInventory :-
	/*Gatau belum ngerti cara milih barang di inventory*/
	
whichTurn :- /*Bisa aja yang enemy yang mau attack*/
	randInterval(0,13,X),
	X=13, retract(enemyturn(_)), assert(enemyturn(1)), !.
	X/=13, retract(playerturn(_)), assert(playerturn(1)). 
	
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
    player_status(IDName,0,_).

checkwin :-
    enemy_status(BossEnemy,0,_).

enemy_attack:- /*Sama, tapi pas turn enemy*/

enemy_specialattack:- /*Sama, tapi pas turn enemy*/

run :-
    randInterval(0,1,X),
    X = 1, runsuccess,!.
    X = 0, runfail,!.

runfail:-
    write('Bad luck! You are not able to run~'),
    fight.

runsuccess:-
    retract(inbattle(_,Player,1),
    retract(amountofenemy(1)),
    write('You successfully run from the enemy.'),
    assert(inbattle(_,Player,0),
    assert(amountofenemy(0)). /*Dibikin jadi 0 artinya dia keluar dari battle*/

/*Inget selalu dicek lagi inBattle apa ngga*/
/*Cek diri sendiri, enemy, boss enemy, kalo udah selesai ya menang*/
/*Ada bagian turn musuh*/
/*Ngecek enemy dead*/
/*Damagenya berdasarkan inventory*/
/*Perlevelan gimana ya*/
