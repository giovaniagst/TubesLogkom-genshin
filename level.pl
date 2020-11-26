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

gold(1000).
health(500).
attack(100).

/*** RULE addExp ***/
/* addExp(Job,Level,CurrentExp, PlusExp, Naik) */
/* Plus Exp adalah banyaknya Exp yang ingin ditambahkan */
/* Naik adalah boolean yang menandakan player sudah naik level atau belum */
/* 1 jika true, 0 false */
addExp(Job,Level,CurrentExp,PlusExp,Naik):-
    Level =< 1,!,
    NewExp is CurrentExp + PlusExp,
    (NewExp >= 100 -> Naik is 1; Naik is 0),
    write('Congrats! Now your '), write(Job), write(' is level 2'). %nanti ganti kata2 apa gt wkwk

addExp(Job,Level,CurrentExp,PlusExp,Naik):-
    Level =< 2,!,
    NewExp is CurrentExp + PlusExp,
    (NewExp >= 300 -> Naik is 1; Naik is 0),
    write('Congrats! Now your '), write(Job), write(' is level 3').

addExp(Job,Level,CurrentExp,PlusExp,Naik):-
    Level =< 3,!,
    NewExp is CurrentExp + PlusExp,
    (NewExp >= 500 -> Naik is 1; Naik is 0),
    write('Congrats! Now your '), write(Job), write(' is level 4').

addExp(Job,Level,CurrentExp,PlusExp,Naik):-
    Level =< 4,!,
    NewExp is CurrentExp + PlusExp,
    (NewExp >= 750 -> Naik is 1; Naik is 0),
    write('Congrats! Now your '), write(Job), write(' is level 5').

addExp(Job,Level,CurrentExp,PlusExp,Naik):-
    Level =< 5,!,
    NewExp is CurrentExp + PlusExp,
    (NewExp >= 1200 -> Naik is 1; Naik is 0),
    write('Congrats! Now your '), write(Job), write(' is level 6').

addExp(Job,Level,CurrentExp,PlusExp,Naik):-
    Level =< 6,!,
    NewExp is CurrentExp + PlusExp,
    (NewExp >= 1800 -> Naik is 1; Naik is 0),
    write('Congrats! Now your '), write(Job), write(' is level 7').

addExp(Job,Level,CurrentExp,PlusExp,Naik):-
    Level =< 7,!,
    NewExp is CurrentExp + PlusExp,
    (NewExp >= 2500 -> Naik is 1; Naik is 0),
    write('Congrats! Now your '), write(Job), write(' is level 8').

addExp(Job,Level,CurrentExp,PlusExp,Naik):-
    Level =< 8,!,
    NewExp is CurrentExp + PlusExp,
    (NewExp >= 3200 -> Naik is 1; Naik is 0),
    write('Congrats! Now your '), write(Job), write(' is level 9').

addExp(Job,Level,CurrentExp,PlusExp,Naik):-
    Level =< 9,!,
    NewExp is CurrentExp + PlusExp,
    (NewExp >= 4000 -> Naik is 1; Naik is 0),
    write('Congrats! Now your '), write(Job), write(' is level 10').

addExp(Job,Level,CurrentExp,PlusExp,Naik):- % Level mentok ceritanya
    Level =< 10,!,
    NewExp is CurrentExp + PlusExp,
    (NewExp >= 5000 -> Naik is 1; Naik is 0),
    write('Congrats! Now your '), write(Job), write(' sudah mencapai level maksimum.'),nl,
    write('Silahkan berhenti bermain dan kembali ke kehidupan anda.').

/*** RULES NAIK STAT (ATTACK, HEALTH, MONEY) ***/
naikStat(Job,Level,CurrentExp,PlusExp) :-
    addExp(Job,Level,CurrentExp,PlusExp,Naik),
    Naik == 1,
    gold(Uang), health(Darah), attack(Serang),
    Uang1 is Uang+500,
    Darah1 is Darah+50,
    Serang1 is Serang+100,
    asserta(gold(Uang1)), retract(gold(Uang)),
    asserta(health(Darah1)), retract(health(Darah)),
    asserta(attack(Serang1)), retract(attack(Serang)).

printStat:-
    gold(G), health(H), attack(A),
    write('PLAYER STAT`S'),nl,
    write('Gold     :   '), write(G),nl,
    write('Health   :   '), write(H),nl,
    write('Attack   :   '), write(A),nl.