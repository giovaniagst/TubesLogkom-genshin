/* nama file : enemy.pl */

/* Musuh minimal terdiri dari 3 jenis, yaitu slime, goblin, dan wolf. */
/* Tiap musuh memiliki status level, HP, Attack, dan Defense sendiri. */
/* Sistem status musuh yang muncul dibebaskan. */
/* Terdapat juga boss musuh yang harus dikalahkan untuk memenangkan game.*/
/* Boss tersebut berada di boss dungeon yang terletak di suatu tiles di map.*/
/* Boss memiliki status yang sama sepanjang permainan */
/* (semisal level 70, attack 1000, dan defense 1000). */


/** ENEMY FACT : enemy(nama,level,health,attack,defense) **/
:- dynamic(enemy/4).

/** BOSS FACT : boss(level,health,attack,defense) */
:- dynamic(boss/5).

decide(X):-
	X==3,
	asserta(enemy(slime,3,1800,180,90)),!.

decide(X):-
	X==1,
	asserta(enemy(goblin,1,1200,100,70)),!.

decide(X):-
	X==2,
	asserta(enemy(wolf,2,1500,130,80)),!.

/** RANDOMIZE ENEMY (based on enemy's level) **/ % sementara berdasarkan level
random_enemy:-
    random(1,4,X),
    decide(X),!,
    enemy(A,B,C,D,E),
    capitalize_enemy_name(A,F),
    write('Enemy`s Status'),nl, % gimana cara print kutipnya ya?
    write(''),nl,
    write(F),nl,
    write('Level : '),write(B),nl,
    write('Health : '),write(C),nl,
    write('Attack : '),write(D),nl,
    write('Defense : '),write(E),!.

capitalize_enemy_name(X,Y):-
    X == 'slime',
    Y = 'SLIME'.

capitalize_enemy_name(X,Y):-
    X == 'goblin',
    Y = 'GOBLIN'.

capitalize_enemy_name(X,Y):-
    X == 'wolf',
    Y = 'WOLF'.

/* Boss memiliki status yang sama sepanjang permainan (semisal level 70, attack 1000, defense 1000) */
initBoss :-
    asserta(enemy(boss,70,8000,800,1000)).

generate_boss :-
    initBoss,
    enemy(boss,A,B,C,D),
    write('Enemy`s Status'),nl,
    write(''),nl,
    write('BOSS'),nl,
    write('Level : '),write(A),nl,
    write('Health : '),write(B),nl,
    write('Attack : '),write(C),nl,
    write('Defense : '),write(D).
