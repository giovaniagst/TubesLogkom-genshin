/* nama file : shop.pl */

:- include('inventory.pl').
:- include('player.pl').

/**** EQUIPMENT FACT ****/

/* semakin bagus weapon-nya maka semakin tinggi damage yang dihasilkan?? */
/* armor berguna untuk reduce damage dari musuh?? */

/* equipment(nomor,nama) */
/* Swordsman */
equipment(1,wooden_sword).
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
equipment(11,health_potion).
:- dynamic(belanja/1).
/* misal gold awal 2000 */

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

shop1:-
    shop_header,
    asserta(belanja(1)),
    gold(X),
    write('Your current gold is '),write(X),nl,
    write('What do you want to buy?'),nl,
    write('1.   Equipment Gacha (1000 gold)'),nl,
    write('2.   Health potion (500 gold)'),nl,
    write('Input number menu(1/2) : '), read(Y), number_menu(Y).
/* apabila memilih equipment gacha maka akan di-generate suatu equipment acak */

shop1:-
    belanja(_),
    write('Do you need anything else? (y/n) : '),
    read(X),!,
    (X==n -> retractall(belanja(_)),
    write(''),nl,
    write('Exited from shop.') ; shop1).

/** MEMBACA INPUT USER **/
number_menu(1):- /* ketika gold cukup untuk gacha */
    gold(X),
    X>=1000,
    X1 is X-1000,
    asserta(gold(X1)),
    retract(gold(X)),!,
    gacha(Y),
    input(Y,Get),
    write(''),nl,
    (Get==1 ->
        write('Gotcha, a '), write(Y), write(' is ready to be yours!'),nl,
        write('Your remaining gold is '), write(X1),!;
    Get==0 ->
        write('Kamu memperoleh equipment yang tidak sesuai dengan character'),nl,
        write('Gacha failed'),nl,
        write('Your remaining gold is '), write(X1)).

    
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
    input(health_potion,_),
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
    random(1,11,X), /* banyaknya equipment sementara adalah 10, bisa berubah sewaktu-waktu */
    equipment(X,HasilGacha).

/** ASSERT KE INVENTORY **/
input(HasilGacha,Get):-
    total(T), 
    T<100,
    character(Char),
    Char == swordman,

    T1 is T+1,
    retractall(total(_)),
    asserta(total(T1)),

    (HasilGacha == wooden_sword -> haveE(wooden_sword,X,100), %if-else mulai dr sini
    Y is X+1,
    retractall(haveE(wooden_sword,_,_)),
    asserta(haveE(wooden_sword,Y,100)),
    Get is 1;

    HasilGacha == wooden_armor -> haveA(wooden_armor,X,_),
    Y is X+1,
    retractall(haveA(wooden_armor,_,_)),
    asserta(haveA(wooden_armor,Y,80)),
    Get is 1;
    
    HasilGacha == king_sword -> haveE(king_sword,X,150),
    Y is X+1,
    retractall(haveE(king_sword,_,_)),
    asserta(haveE(king_sword,Y,150)),
    Get is 1;

    HasilGacha == king_armor -> haveA(king_armor,X,_),
    Y is X+1,
    retractall(haveA(king_armor,_,_)),
    asserta(haveA(king_armor,Y,90)),
    Get is 1;
    
    HasilGacha == iron_armor -> haveA(iron_armor,X,_),
    Y is X+1,
    retractall(haveA(iron_armor,_,_)),
    asserta(haveA(iron_armor,Y,85)),
    Get is 1;

    HasilGacha == health_potion -> haveH(health_potion,X,_),
    Y is X+1,
    retractall(haveH(health_potion,_,_)),
    asserta(haveH(health_potion,Y,1000)),
    Get is 1; Get is 0).

input(HasilGacha,Get):-
    total(T), 
    T<100,
    character(Char),
    Char == archer,

    T1 is T+1,
    retractall(total(_)),
    asserta(total(T1)),

    (HasilGacha == wooden_bow -> haveE(wooden_bow,X,_), %if-else mulai dr sini
    Y is X+1,
    retractall(haveE(wooden_bow,_,_)),
    asserta(haveE(wooden_bow,Y,100)),
    Get is 1;

    HasilGacha == wooden_armor -> haveA(wooden_armor,X,_),
    Y is X+1,
    retractall(haveA(wooden_armor,_,_)),
    asserta(haveA(wooden_armor,Y,80)),
    Get is 1;
    
    HasilGacha == iron_bow -> haveA(iron_bow,X,_),
    Y is X+1,
    retractall(haveA(iron_bow,_,_)),
    asserta(haveA(iron_bow,Y,150)),
    Get is 1;

    HasilGacha == steel_bow -> haveA(steel_bow,X,_),
    Y is X+1,
    retractall(haveA(steel_bow,_,_)),
    asserta(haveA(steel_bow,Y,200)),
    Get is 1;

    HasilGacha == health_potion -> haveH(health_potion,X,_),
    Y is X+1,
    retractall(haveH(health_potion,_,_)),
    asserta(haveH(health_potion,Y,1000)),
    Get is 1; Get is 0).

input(HasilGacha,Get):-
total(T), 
    T<100,
    character(Char),
    Char == sorcerer,

    T1 is T+1,
    retractall(total(_)),
    asserta(total(T1)),
    (HasilGacha == magic_book -> haveE(magic_book,X,_), %if-else mulai dr sini
    Y is X+1,
    retractall(haveE(magic_book,_,_)),
    asserta(haveE(magic_book,Y,150)),
    Get is 1;

    HasilGacha == wooden_armor -> haveA(wooden_armor,X,_),
    Y is X+1,
    retractall(haveA(wooden_armor,_,_)),
    asserta(haveA(wooden_armor,Y,80)),
    Get is 1;
    
    HasilGacha == magic_robe -> haveA(magic_robe,X,_),
    Y is X+1,
    retractall(haveA(magic_robe,_,_)),
    asserta(haveA(magic_robe,Y,200)),
    Get is 1;

    HasilGacha == health_potion -> haveH(health_potion,X,_),
    Y is X+1,
    retractall(haveH(health_potion,_,_)),
    asserta(haveH(health_potion,Y,1000)),
    Get is 1; Get is 0).