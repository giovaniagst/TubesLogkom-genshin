/* Untuk player.pl */

:- dynamic(level/1).
:- dynamic(health/1).
:- dynamic(attack/1).
:- dynamic(defense/1).
:- dynamic(exp/1).
:- dynamic(gold/1).
:- dynamic(playing/0).



/* fakta untuk player */

/* jenis character */
/*a_character :-
    asserta(character(swordman)),
    asserta(character(archer)),
    asserta(character(sorcerer)).*/

/* level tiap character */
/*a_level :-
    asserta(level(swordman,1)),
    asserta(level(archer,1)),
    asserta(level(sorcerer,1)).*/

/* health tiap character */
/*a_health :-
    asserta(health(swordman,1000)),
    asserta(health(archer,1000)),
    asserta(health(sorcerer,1000)).*/

/* attack tiap character */
/*a_attack :-
    asserta(attack(swordman,100)),
    asserta(attack(archer,110)),
    asserta(attack(sorcerer,105)).*/

/* defense tiap character */
/*a_defense :-
    asserta(defense(swordman,90)),
    asserta(defense(archer,85)),
    asserta(defense(sorcerer,80)).*/

/* exp tiap pemain */
/*a_exp :-
    asserta(exp(swordman,0)),
    asserta(exp(archer,0)),
    asserta(exp(sorcerer,0)).*/

/* gold tiap pemain */
/*a_gold :-
    asserta(gold(swordman,1000)),
    asserta(gold(archer,1000)),
    asserta(gold(sorcerer,1000)).*/

swordman :-
    asserta(level(1)),
    asserta(health(1000)),
    asserta(attack(100)),
    asserta(defense(90)),
    asserta(exp(0)),
    asserta(gold(1000)).

archer :-
    asserta(level(1)),
    asserta(health(1000)),
    asserta(attack(110)),
    asserta(defense(85)),
    asserta(exp(0)),
    asserta(gold(1000)).

sorcerer :-
    asserta(level(1)),
    asserta(health(1000)),
    asserta(attack(105)),
    asserta(defense(80)),
    asserta(exp(0)),
    asserta(gold(1000)).

/* rules untuk player */
choose_character :-
    write('Welcome to GENSHIN ADVENTURE. Choose your character'), nl,
    write('1. Swordman'), nl,
    write('2. Archer'), nl,
    write('3. Sorcerer'), nl,
    read(X), nl,
    (X =:= 1 -> write('Welcome to the adventure, Swordman!'), nl, write('You got a Wooden Sword, Wooden Armor, and 5 Health Potion'), nl, write('Lets finish the job!'), nl, swordman;
    X =:= 2 -> write('Welcome to the adventure, Archer!'), nl, write('You got a Wooden Bow, Wooden Armor, and 5 Health Potion'), nl, write('Lets finish the job!'), nl, archer;
    X =:= 3 -> write('Welcome to the adventure, Sorcerer!'), nl, write('You got a Magic Book, Wooden Armor, and 5 Health Potion'), nl, write('Lets finish the job!'), nl, sorcerer).
