/* Untuk player.pl */
:- dynamic(character/1).
:- dynamic(level/2).
:- dynamic(health/2).
:- dynamic(attack/2).
:- dynamic(defense/2).
:- dynamic(exp/2).
:- dynamic(gold/2).
:- dynamic(invent/2).
:- dynamic(quant/2).

:- discontiguous(a_character/0).
:- discontiguous(a_level/0).
:- discontiguous(a_health/0).
:- discontiguous(a_attack/0).
:- discontiguous(a_defense/0).
:- discontiguous(a_exp/0).
:- discontiguous(a_gold/0).
:- discontiguous(a_inventory/0).

/* fakta untuk player */

/* jenis character */
a_character :-
    asserta(character(swordman)),
    asserta(character(archer)),
    asserta(character(sorcerer)).

/* level tiap character */
a_level :-
    asserta(level(swordman,1)),
    asserta(level(archer,1)),
    asserta(level(sorcerer,1)).

/* health tiap character */
a_health :-
    asserta(health(swordman,1000)),
    asserta(health(archer,1000)),
    asserta(health(sorcerer,1000)).

/* attack tiap character */
a_attack :-
    asserta(attack(swordman,100)),
    asserta(attack(archer,110)),
    asserta(attack(sorcerer,105)).

/* defense tiap character */
a_defense :-
    asserta(defense(swordman,90)),
    asserta(defense(archer,85)),
    asserta(defense(sorcerer,80)).

/* exp tiap pemain */
a_exp :-
    asserta(exp(swordman,0)),
    asserta(exp(archer,0)),
    asserta(exp(sorcerer,0)).

/* gold tiap pemain */
a_gold :-
    asserta(gold(swordman,1000)),
    asserta(gold(archer,1000)),
    asserta(gold(sorcerer,1000)).

/* inventory awal */
a_inventory :-
    asserta(invent(swordman,[quant(wooden_sword,1),quant(wooden_armor,1),quant(health_potion,5)])).
    asserta(invent(archer,[quant(wooden_bow,1),quant(wooden_armor,1),quant(health_potion,5)])).
    asserta(invent(sorcerer,[quant(magic_book,1),quant(wooden_armor,1),quant(health_potion,5)])).

/* rules untuk player */
choose_character :-
    write('Welcome to GENSHIN ADVENTURE. Choose your character'), nl,
    write('1. Swordman'), nl,
    write('2. Archer'), nl,
    write('3. Sorcerer'), nl,
    read(X), nl,
    (X =:= 1 -> write('Welcome to the adventure, Swordman!'), nl, write('You got a Wooden Sword, Wooden Armor, and 5 Health Potion'), nl, write("Let's finish the job!"), nl, character(swordman);
    X =:= 2 -> write('Welcome to the adventure, Archer!'), nl, write('You got a Wooden Bow, Wooden Armor, and 5 Health Potion'), nl, write("Let's finish the job!"), nl, character(archer);
    X =:= 3 -> write('Welcome to the adventure, Sorcerer!'), nl, write('You got a Magic Book, Wooden Armor, and 5 Health Potion'), nl, write("Let's finish the job!"), nl, character(sorcerer)).

addNewEquipment :-
    character(X),
    (X == swordman -> invent(swordman,[quant(wooden_sword,1),quant(wooden_armor,1),quant(health_potion,5),quant(A,B)]);
    X == archer -> invent(archer,[quant(wooden_bow,1),quant(wooden_armor,1),quant(health_potion,5),quant(A,B)]);
    X == sorcerer -> invent(sorcerer,[quant(magic_book,1),quant(wooden_armor,1),quant(health_potion,5), quant(A,B)])),
    C is A + B + 7, C =< 100.

addInventory :-
    character(X),
    (X == swordman -> invent(swordman,[quant(wooden_sword,A),quant(wooden_armor,B),quant(health_potion,C)]);
    X == archer -> invent(archer,[quant(wooden_bow,A),quant(wooden_armor,B),quant(health_potion,C)]);
    X == sorcerer -> invent(sorcerer,[quant(magic_book,A),quant(wooden_armor,B),quant(health_potion,C)])),
    D is A + B + C, D =< 100.
