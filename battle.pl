:- include('inventory.pl').
:- include('enemy.pl').
:- include('player.pl').
:- dynamic(amountofenemy/1).
:- dynamic(inbattle/3).
:- dynamic(player_status/3).
:- dynamic(playerturn/1).
:- dynamic(enemyfound/1).
:- dynamic(takequest/3).

take_q :-
        quest(_,_),
	write('Take your quest here!'),nl,
	random(3,4,X),
	random(3,5,Y),
	random(3,6,Z),
	asserta(takequest(X,Y,Z)).
	write('You got'),write(X),write('	

startbattle :-
	dungeon(_,_),
	write('You found yourself a'),nl,
        generate_boss,
	write('This will be the battle that determines your future...'),nl,
	write('Write start(X), with X being your job (swordman/archer/sorcerer).'),nl.

inquest :-
	takequest(X,Y,Z),X>0,Y>0,Z>0.

startbattle :-
	inquest,
	write('You found yourself a'),nl,
	random_enemy,	
	write('Choose start(X), with X being your job (swordman/archer/sorcerer).'),nl.
 
start(X):-
	X=swordman,
	inventory_swordman,
	swordman,
	health(Hea),
	attack(Att),
	defense(Def),
	asserta(player_status(Hea,Att,Def)),
	enemyfound.

start(X):-
	X=archer,
	inventory_archer,
	archer,
	health(Hea),
	attack(Att),
	defense(Def),
	asserta(player_status(Hea,Att,Def)),
	enemyfound.

start(X):-
	X=sorcerer,
	inventory_sorcerer,
	sorcerer,
	health(Hea),
	attack(Att),
	defense(Def),
    	asserta(player_status(Hea,Att,Def)),
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
	haveH(health_potion,Amount,_),
        Amount \=0,
	haveH(health_potion,_,AddHea),
	retract(player_status(Hea,Att,Def)),
	delFromInventory(health_potion),  
	NewHea is Hea + AddHea,      
	asserta(player_status(NewHea,Att,Def)),
	write('Success! Health improved!'),
	fight,!.

use_potion:-    
	haveH(health_potion,Amount,_),
        Amount=0,
        write('No health potion to use'),nl.

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
    write('> justattack. --- to proceed without equipments,'),nl,
    write('> showinventory. --- if you want to use some to add your attack.'),nl.

justattack :-
    retract(enemy(Name,_,Hea,Att,Def)),
    retract(player_status(Health,A,Defense)),
    random(30,50,Dmg),
    write(Dmg),
    write(' damage hits '),
    write(Name),nl,  
    random(0,Def,Y),
    write('Nevertheless, '),
    write(Name),
    write(' used his '),
    write(Y),
    write(' defense'),nl,
    RealY is 0.5 * Y,
    RealDmg is Dmg - RealY,
    NewHea is Hea - RealDmg,
    NewA is A - Dmg,
    NewDef is Def - RealY,
    asserta(enemy(Name,_,NewHea,Att,NewDef)),
    asserta(player_status(Health,NewA,Defense)),
    check_enemydead,
    whichTurn,!.

use(W) :-
    haveE(W,Amount,Dmg),
    Amount \=0,
    write('You used your '),write(W),nl,
    write(' to add '),write(Dmg),write(' damage.'),nl,
    retract(enemy(Name,_,Hea,Att,Def)),
    retract(player_status(Health,A,Defense)),
    random(0,Att,Dmg1),
    TotalDmg is Dmg + Dmg1,
    write(TotalDmg),
    write(' damage hits '),
    write(Name),nl,  
    random(0,Def,Y),
    write('Nevertheless, '),
    write(Name),
    write(' used his '),
    write(Y),
    write(' defense'),nl,
    RealY is 0.5 * Y,
    RealDmg is TotalDmg - RealY,
    NewHea is Hea - RealDmg,
    NewA is A - Dmg1,
    NewDef is Def - RealY,
    delFromInventory(W),
    asserta(enemy(Name,_,NewHea,Att,NewDef)),
    asserta(player_status(Health,NewA,Defense)),
    check_enemydead,
    whichTurn,!.

use(W) :-
    \+haveE(W,_,_),
    write('You do not have that your inventory.'),nl,
    write('Proceed with justattack or use another weapon.'),nl.

use(W):-
    haveE(W,Amount,_),
    Amount=0,
    write('OUT OF STOCK!'),nl,
    write('Youll be redirected to use attack without weapon.'),nl,
    justattack.

showinventory:-
	haveE(Weapon,Amount,_),
        Amount\=0,
	write('Choose by writing use(weaponname)'),nl,
        write('WEAPON NAME-AMOUNT'),nl,
	forall(haveE(Weapon,_,_),(write(Weapon-Amount),nl)),!.

showinventory:-
	haveE(_,Amount,_),
        Amount=0,
	write('Oopsie. No weapon to be used.'),nl,!.
	
special_attack :-
    inbattle(_,_,1),
    playerturn(1),
    random(0,3,X),
    specialattack_able(X).

specialattack_able(X):-
    X=0,    
    retract(enemy(Name,_,Hea,Att,Def)),
    retract(player_status(Health,A,Defense)),
    random(10,A,Dmg),
    write(Dmg),
    write(' damage hits '),
    write(Name),nl,  
    random(0,Def,Y),
    write('Nevertheless, '),
    write(Name),
    write(' used his '),
    write(Y),
    write(' defense'),nl,
    RealY is 0.5 * Y,
    RealDmg is Dmg - RealY,
    NewHea is Hea - RealDmg,
    NewA is A - Dmg,
    NewDef is Def - RealY,
    asserta(enemy(Name,_,NewHea,Att,NewDef)),
    asserta(player_status(Health,NewA,Defense)),
    check_enemydead,
    whichTurn,!.

specialattack_able(X):-
    X\=0,
    write('Sorryyy, you are not able to use this now, choose other options.'),nl,
    write('- attack.'),nl,
    write('- use_potion.').

enemyattack:-
    enemy(_,_,_,A,_),
    A =< 0,
    retract(inbattle(_,_,_)),
    asserta(inbattle(_,_,0)),
    write('Your enemy cannot attack anymore. YOU WON.'),nl,
    whichTurn,!.

enemyattack :-
    enemy(Name,_,_,A,_),
    inbattle(_,_,1),
    playerturn(0),
    retract(enemy(Name,_,H,A,D)),
    write('BOOM!'),nl,
    random(0,A,Dmg),
    write(Dmg),
    write(' damage hits you'),nl,
    retract(player_status(Hea,Att,Def)),
    Def > 0,
    random(0,Def,Y),
    write('Nevertheless, you used your '),
    write(Y),
    write(' defense'),nl,
    RealY is 0.5 * Y,
    RealDmg is Dmg - RealY,
    NewA is A - Dmg,
    asserta(enemy(Name,_,H,NewA,D)),
    NewHea is Hea - RealDmg,
    NewDef is Def - RealY,
    asserta(player_status(NewHea,Att,NewDef)),
    check_playerdead,
    whichTurn,!.

enemyattack :-
    enemy(Name,_,_,A,_),
    inbattle(_,_,1),
    playerturn(0),
    retract(enemy(Name,_,H,A,D)),
    write('BOOM!'),nl,
    random(0,A,Dmg),
    write(Dmg),
    write(' damage hits you'),nl,
    retract(player_status(Hea,Att,Def)),
    Def =< 0,
    NewA is A - Dmg,
    asserta(enemy(Name,_,H,NewA,D)),
    NewHea is Hea - Dmg,
    asserta(player_status(NewHea,Att,Def)),
    check_playerdead,
    whichTurn,!.

check_enemydead :-
	enemy(_,_,Hea,_,_),
	Hea =< 0,
	retract(inbattle(_,_,_)),
	asserta(inbattle(_,_,0)),
	write('The enemy has fallen.'),!.

check_enemydead :-
	enemy(_,_,Hea,_,_),
	Hea > 0,
        checkattackenemy,!.

checkattackenemy :-
    enemy(_,_,_,Att,_),
    Att =< 0,
    retract(inbattle(_,_,_)),
    asserta(inbattle(_,_,0)),
    write('Your enemy cannot attack anymore. YOU WON.'),nl,!.

checkattackenemy:-
   enemy(_,_,_,Att,_),
   Att > 0,!.

check_playerdead :-
	player_status(Hea,_,_),
	Hea =< 0,
	retract(inbattle(_,_,_)),
	asserta(inbattle(_,_,0)),
	write('YOU DIED.'),halt,!.

check_playerdead:-
	player_status(Hea,_,_),
	Hea > 0,
	checkattack,!.

checkattack :-
    player_status(_,Att,_),
    Att =< 0,
    haveE(_,W,_),
    W = 0,
    retract(inbattle(_,_,_)),
    asserta(inbattle(_,_,0)),
    write('You cannot attack anymore. YOU LOSE.'),nl,!.

checkattack:-
    player_status(_,Att,_),
    haveE(_,W,_),
    Att > 0,
    W =< 0,!. /*Gabisa pake inventory*/

checkattack:-
    player_status(_,Att,_),
    haveE(_,W,_),
    Att =< 0,
    W > 0,!. /*Cuma bisa pake inventory*/

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
        write('Do you want to use defense or not?'),nl,
        write('- showdefense.'),nl,
        write('or else,'),nl,
        write('- proceed.'),nl,!.

whichTurn :-
	inbattle(_,_,0),
	write('END OF BATTLE!'),nl,!.

proceed :-
	enemyattack,!.

showdefense :-
	haveA(Armor,Amount,_),
        Amount\=0,
	write('Choose by writing usea(name)'),nl,
        write('ARMOR NAME-AMOUNT'),nl,
	forall(haveA(Armor,_,_),(write(Armor-Amount),nl)),!.

showdefense :-
	haveA(_,Amount,_),
        Amount=0,
	write('Oopsie, nothing here.'),nl,
	write('Cannot add your defense~~'),nl,nl,nl,
        enemyattack,!.

usea(A) :-
    \+haveA(A,_,_),
    write('You do not have that your inventory.'),nl,
    write('Youll be redirected without adding defense.'),nl,
    enemyattack,!.

usea(A) :-
    haveA(A,Amount,AddDef),
    Amount\=0,
    retract(player_status(Att,Hea,Def)),
    NewDef is Def + AddDef,
    asserta(player_status(Att,Hea,NewDef)), 
    write('Defense boosted, youre ready to go.'),nl,
    delFromInventory(A),
    enemyattack,!.

usea(A):-
    haveA(A,Amount,_),
    Amount=0,
    write('OUT OF STOCK!'),nl,
    write('Youll be redirected without adding defense.'),nl,
    enemyattack,!.
