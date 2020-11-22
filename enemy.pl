/* nama file : enemy.pl */

/* Musuh minimal terdiri dari 3 jenis, yaitu slime, goblin, dan wolf. */
/* Tiap musuh memiliki status level, HP, Attack, dan Defense sendiri. */
/* Sistem status musuh yang muncul dibebaskan. */
/* Terdapat juga boss musuh yang harus dikalahkan untuk memenangkan game.*/
/* Boss tersebut berada di boss dungeon yang terletak di suatu tiles di map.*/
/* Boss memiliki status yang sama sepanjang permainan */
/* (semisal level 70, attack 1000, dan defense 1000). */


/** ENEMY FACT : enemy(nama,level,health,attack,defense) **/
enemy(slime,3,90,90,90).
enemy(goblin,1,90,70,70).
enemy(wolf,2,90,80,80).

/** RANDOMIZE ENEMY (based on enemy's level) **/ % sementara berdasarkan level
random_enemy:-
    random(1,3,X),
    enemy(A,X,B,C,D),
    capitalize_enemy_name(A,E),
    write('Enemy`s Status'),nl, % gimana cara print kutipnya ya?
    write(''),nl,
    write(E),nl,
    write('Level : '),write(X),nl,
    write('Health : '),write(B),nl,
    write('Attack : '),write(C),nl,
    write('Defense : '),write(D).

capitalize_enemy_name(X,Y):-
    X == 'slime',
    Y = 'SLIME'.

capitalize_enemy_name(X,Y):-
    X == 'goblin',
    Y = 'GOBLIN'.

capitalize_enemy_name(X,Y):-
    X == 'wolf',
    Y = 'WOLF'.

