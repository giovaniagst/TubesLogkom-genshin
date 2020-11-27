/* file : player.pl */

:- dynamic(level/1).
:- dynamic(health/1).
:- dynamic(attack/1).
:- dynamic(defense/1).
:- dynamic(expo/1).
:- dynamic(gold/1).
:- dynamic(player/2).
:- dynamic(job/2).
:- dynamic(player_status/1).

/* fakta player */
character(swordman).
character(archer).
character(sorcerer).

char_swordman :-
    asserta(job(X,swordman)),
    asserta(level(1)),
    asserta(health(1000)),
    asserta(attack(100)),
    asserta(defense(90)),
    asserta(expo(0)),
    asserta(gold(1000)).

char_archer :-
    asserta(job(X,archer)),
    asserta(level(1)),
    asserta(health(1000)),
    asserta(attack(110)),
    asserta(defense(85)),
    asserta(expo(0)),
    asserta(gold(1000)).

char_sorcerer :-
    asserta(job(X,sorcerer)),
    asserta(level(1)),
    asserta(health(1000)),
    asserta(attack(105)),
    asserta(defense(80)),
    asserta(expo(0)),
    asserta(gold(1000)).

/* rules untuk player */
choose_character :-
    write('Welcome to GENSHIN ADVENTURE. Choose your character'), nl,
    write('1. Swordman'), nl,
    write('2. Archer'), nl,
    write('3. Sorcerer'), nl,
    read(X), nl,
    (X =:= 1 -> write('Welcome to the adventure, Swordman!'), nl, write('You got a Wooden Sword, Wooden Armor, and 5 Health Potion'), nl, write('Lets finish the job!'), nl, character(swordman), char_swordman;
    X =:= 2 -> write('Welcome to the adventure, Archer!'), nl, write('You got a Wooden Bow, Wooden Armor, and 5 Health Potion'), nl, write('Lets finish the job!'), nl, character(archer), char_archer;
    X =:= 3 -> write('Welcome to the adventure, Sorcerer!'), nl, write('You got a Magic Book, Wooden Armor, and 5 Health Potion'), nl, write('Lets finish the job!'), nl, character(sorcerer), char_sorcerer).

player_place :-
    asserta(player(1,1)).

player_status(X) :-
    write('Your current status :'), nl,
    write(''), nl,
    character(X),
    (X == swordman ->
        write('Job : '), 
        forall(job(_,Job),write(Job)), nl,
        write('Level : '),
        forall(level(Level),write(Level)), nl,
        write('Health : '), 
        forall(health(Health),write(Health)),
        write('/1000'), nl,
        write('Attack : '), 
        forall(attack(Attack),write(Attack)), nl,
        write('Defense : '), 
        forall(defense(Defense),write(Defense)), nl,
        write('EXP : '), 
        forall(expo(Exp),write(Exp)),
        write('/300'), nl,
        write('Gold : '), 
        forall(gold(Gold),write(Gold));
    X == archer ->
        write('Job : '), 
        forall(job(_,Job),write(Job)), nl,
        write('Level : '),
        forall(level(Level),write(Level)), nl,
        write('Health : '), 
        forall(health(Health),write(Health)),
        write('/1000'), nl,
        write('Attack : '), 
        forall(attack(Attack),write(Attack)), nl,
        write('Defense : '), 
        forall(defense(Defense),write(Defense)), nl,
        write('EXP : '), 
        forall(expo(Exp),write(Exp)),
        write('/300'), nl,
        write('Gold : '), 
        forall(gold(Gold),write(Gold));
    X == sorcerer ->
        write('Job : '), 
        forall(job(_,Job),write(Job)), nl,
        write('Level : '),
        forall(level(Level),write(Level)), nl,
        write('Health : '), 
        forall(health(Health),write(Health)),
        write('/1000'), nl,
        write('Attack : '), 
        forall(attack(Attack),write(Attack)), nl,
        write('Defense : '), 
        forall(defense(Defense),write(Defense)), nl,
        write('EXP : '), 
        forall(expo(Exp),write(Exp)),
        write('/300'), nl,
        write('Gold : '), 
        forall(gold(Gold),write(Gold)),!),!.
