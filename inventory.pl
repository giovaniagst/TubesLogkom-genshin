/* file : inventory.pl */

:- dynamic(have/2).
:- dynamic(total/1).

/* inventory awal masing-masing character */
inventory_swordman :-
    asserta(total(7)),
    asserta(have(health_potion,5)),
    asserta(have(wooden_sword,1)),
    asserta(have(wooden_armor,1)),
    asserta(have(king_sword,0)),
    asserta(have(iron_armor,0)),
    asserta(have(king_armor,0)).

inventory_archer :-
    asserta(total(7)),
    asserta(have(health_potion,5)),
    asserta(have(wooden_bow,1)),
    asserta(have(wooden_armor,1)),
    asserta(have(iron_bow,0)),
    asserta(have(steel_bow,0)).
    
inventory_sorcerer :-
    asserta(total(7)),
    asserta(have(health_potion,5)),
    asserta(have(magic_book,1)),
    asserta(have(wooden_armor,1)),
    asserta(have(magic_robe,0)).

/* menambahkan item ke inventory */
addToInventory(Nama) :-
    (total(Total), Total < 100 ->
        retract(have(Nama,Jumlah)), 
        Jumlah1 is Jumlah + 1, 
        asserta(have(Nama,Jumlah1)),
        retract(total(Total)),
        Total1 is Total + 1,
        asserta(total(Total1))).

/* menghapus item dari inventory */
delFromInventory(Nama) :-
    retract(have(Nama,Jumlah)),
    Jumlah1 is Jumlah - 1,
    asserta(have(Nama,Jumlah1)),
    retract(total(Total)),
    Total1 is Total + 1,
    asserta(total(Total1)).








