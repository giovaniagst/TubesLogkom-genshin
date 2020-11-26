/* nama file : level.pl */
/* syarat untuk naik level adalah memiliki exp yang cukup */

/* setelah naik level maka player akan memperoleh penambahan pada */
/* health */
/* attack */
/* gold */

/*** TEMPORARY FACT ***/
:- dynamic(gold/1).
:- dynamic(health/1).
:- dynamic(attack/1).
:- dynamic(exp/1).

gold(1000).
health(500).
attack(100).
exp(98).

%%%%%% atau exp dijadiin fakta ??????

/*** RULE addExp ***/
/* addExp(Job,Level,PlusExp, Naik) */
/* Plus Exp adalah banyaknya Exp yang ingin ditambahkan */
/* Naik adalah boolean yang menandakan player sudah naik level atau belum */
/* 1 jika true, 0 false */
addExp(Job,Level,PlusExp,Naik):-
    Level =< 1,!,
    exp(E),
    NewExp is E + PlusExp,
    asserta(exp(NewExp)), retract(exp(E)),
    (NewExp >= 100 -> Naik is 1,
    write('Congrats! Now your '), write(Job), write(' is level 2'); Naik is 0).
    %nanti ganti kata2 apa gt wkwk

addExp(Job,Level,PlusExp,Naik):-
    Level =< 2,!,
    exp(E),
    NewExp is E + PlusExp,
    asserta(exp(NewExp)), retract(exp(E)),
    (NewExp >= 300 ->  Naik is 1,
    write('Congrats! Now your '), write(Job), write(' is level 3'); Naik is 0).

addExp(Job,Level,PlusExp,Naik):-
    Level =< 3,!,
    exp(E),
    NewExp is E + PlusExp,
    asserta(exp(NewExp)), retract(exp(E)),
    (NewExp >= 500 ->  Naik is 1,
    write('Congrats! Now your '), write(Job), write(' is level 4'); Naik is 0).

addExp(Job,Level,PlusExp,Naik):-
    Level =< 4,!,
    exp(E),
    NewExp is E + PlusExp,
    asserta(exp(NewExp)), retract(exp(E)),
    (NewExp >= 750 ->  Naik is 1,
    write('Congrats! Now your '), write(Job), write(' is level 5'); Naik is 0).

addExp(Job,Level,PlusExp,Naik):-
    Level =< 5,!,
    exp(E),
    NewExp is E + PlusExp,
    asserta(exp(NewExp)), retract(exp(E)),
    (NewExp >= 1200 -> Naik is 1,
    write('Congrats! Now your '), write(Job), write(' is level 6'); Naik is 0).

addExp(Job,Level,PlusExp,Naik):-
    Level =< 6,!,
    exp(E),
    NewExp is E + PlusExp,
    asserta(exp(NewExp)), retract(exp(E)),
    (NewExp >= 1800 -> Naik is 1,
    write('Congrats! Now your '), write(Job), write(' is level 7'); Naik is 0).

addExp(Job,Level,PlusExp,Naik):-
    Level =< 7,!,
    exp(E),
    NewExp is E + PlusExp,
    asserta(exp(NewExp)), retract(exp(E)),
    (NewExp >= 2500 -> Naik is 1,
    write('Congrats! Now your '), write(Job), write(' is level 8'); Naik is 0).

addExp(Job,Level,PlusExp,Naik):-
    Level =< 8,!,
    exp(E),
    NewExp is E + PlusExp,
    asserta(exp(NewExp)), retract(exp(E)),
    (NewExp >= 3200 -> Naik is 1,
    write('Congrats! Now your '), write(Job), write(' is level 9'); Naik is 0).

addExp(Job,Level,PlusExp,Naik):-
    Level =< 9,!,
    exp(E),
    NewExp is E + PlusExp,
    asserta(exp(NewExp)), retract(exp(E)),
    (NewExp >= 4000 -> Naik is 1,
    write('Congrats! Now your '), write(Job), write(' is level 10'); Naik is 0).

addExp(Job,Level,PlusExp,Naik):- % Level mentok ceritanya
    Level =< 10,!,
    exp(E),
    NewExp is E + PlusExp,
    asserta(exp(NewExp)), retract(exp(E)),
    (NewExp >= 5000 -> Naik is 1,
    write('Congrats! Now your '), write(Job), write(' sudah mencapai max level, silahkan pulang.'); Naik is 0).

/*** RULES NAIK STAT (ATTACK, HEALTH, MONEY) ***/
naikStat(Job,Level,PlusExp) :-
    addExp(Job,Level,PlusExp,Naik),
    Naik == 1,
    gold(Uang), health(Darah), attack(Serang),
    Uang1 is Uang+500,
    Darah1 is Darah+50,
    Serang1 is Serang+100,
    asserta(gold(Uang1)), retract(gold(Uang)),
    asserta(health(Darah1)), retract(health(Darah)),
    asserta(attack(Serang1)), retract(attack(Serang)).

/* ngetest */
printStat:-
    gold(G), health(H), attack(A), exp(E),
    write('PLAYER STAT`S'),nl,
    write('Gold    :   '), write(G),nl,
    write('Exp     :   '), write(E),nl,
    write('Health  :   '), write(H),nl,
    write('Attack  :   '), write(A),nl.