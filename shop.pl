/* nama file : shop.pl */

/**** EQUIPMENT FACT ****/

/* semakin bagus weapon-nya maka semakin tinggi damage yang dihasilkan?? */
/* armor berguna untuk reduce damage dari musuh?? */

/* equipment(nomor,nama) */
/* Swordsman */
equipment(1,wooden_sword).  % banyakin wooden biar gachanya susah dapet bagus?
equipment(2,king_sword).
equipment(3,wooden_armor).
equipment(4,iron_armor).
equipment(5,king_armor).

/* Archer */
equipment(6,wooden_bow).
equipment(7,iron_bow).
equipment(8,steel_bow).

/* Sorcerer */
equipment(9,magic_book).
equipment(10,magic_robe).

:- dynamic(gold/1).
:- dynamic(belanja/1).
/* misal gold awal 2000 */
gold(2000).

/** SHOP **/
shop_header:-
    write(''),nl,
    write('         dP                         '),nl,
    write('         88                         '),nl,
    write('.d8888b. 88d888b. .d8888b. 88d888b. '),nl,
    write('Y8ooooo. 88`  `88 88`  `88 88`  `88 '),nl,
    write('      88 88    88 88.  .88 88.  .88 '),nl,
    write('`88888P` dP    dP `88888P` 88Y888P` '),nl,
    write('                           88       '),nl,
    write('                           dP       '),nl.

shop:-
    shop_header,
    asserta(belanja(1)),
    gold(X),
    write('Your current gold is '),write(X),nl,
    write('What do you want to buy?'),nl,
    write('1.   Equipment Gacha (1000 gold)'),nl,
    write('2.   Health potion (500 gold)'),nl,
    write('Input number menu(1/2) : '), read(Y), number_menu(Y).
/* apabila memilih equipment gacha maka akan di-generate suatu equipment acak */

shop:-
    belanja(_),
    write('Do you need anything else? (y/n) : '),
    read(X),!,
    (X==n -> retractall(belanja(_)),
    write(''),nl,
    write('Exited from shop.') ; shop).

/** MEMBACA INPUT USER **/
number_menu(1):- /* ketika gold cukup untuk gacha */
    gold(X),
    X>=1000,
    X1 is X-1000,
    asserta(gold(X1)),
    retract(gold(X)),!,
    gacha(Y),
    write(''),nl,
    write('Gotcha, a '), write(Y), write(' is ready to be yours!'),nl,
    write('Your remaining gold is '), write(X1),!.
/* belum assert equipment hasil gacha ke inventory */

number_menu(1):- /* ketika bokek tapi mau gacha */
    gold(X),
    X<1000,
    write(''),nl,
    write('Sorry, your remaining gold is insufficient for this purchase'),!.

number_menu(2):- /* ketika gold cukup beli potion */
    gold(X),
    X>=500,
    X1 is X-500,
    asserta(gold(X1)),
    retract(gold(X)),!,
    write(''),nl,
    write('A health potion is added to your inventory'),nl,
    write('Your remaining gold is '), write(X1).
/* belum assert health potion ke inventory */

number_menu(2):- /* ketika bokek tapi mau potion */
    gold(X),
    X<500,
    write(''),nl,
    write('Sorry, your remaining gold is insufficient for this purchase'),!.

number_menu(X):- /* ketika input bukan 1 atau 2 */
    X\=2,X\=1,
    write('Sorry, your input is not valid.').

/** GACHA **/
gacha(HasilGacha) :-
    random(1,10,X), /* banyaknya equipment sementara adalah 10, bisa berubah sewaktu-waktu */
    equipment(X,HasilGacha).
