/* file : inventory.pl */

:- dynamic(haveH/3).
:- dynamic(haveE/3).
:- dynamic(haveA/3).
:- dynamic(total/1).

/* inventory awal masing-masing character */
inventory_swordman :-
    asserta(total(7)),
    asserta(haveH(health_potion,5,1000)),
    asserta(haveE(wooden_sword,1,100)),
    asserta(haveA(wooden_armor,1,80)),
    asserta(haveE(king_sword,0,150)),
    asserta(haveA(iron_armor,0,85)),
    asserta(haveA(king_armor,0,90)).

inventory_archer :-
    asserta(total(7)),
    asserta(haveH(health_potion,5,1000)),
    asserta(haveE(wooden_bow,1,100)),
    asserta(haveA(wooden_armor,1,80)),
    asserta(haveE(iron_bow,0,150)),
    asserta(haveE(steel_bow,0,200)).
    
inventory_sorcerer :-
    asserta(total(7)),
    asserta(haveH(health_potion,5,1000)),
    asserta(haveE(magic_book,1,150)),
    asserta(haveA(wooden_armor,1,85)),
    asserta(haveE(magic_robe,0,200)).

/* menambahkan item ke inventory */
addToInventory(Nama) :-
    (total(Total), Total < 100 ->
        retract(haveH(Nama,Jumlah)), 
        Jumlah1 is Jumlah + 1, 
        asserta(haveH(Nama,Jumlah1)),
        retract(total(Total)),
        Total1 is Total + 1,
        asserta(total(Total1))).

addToInventory(Nama) :-
    (total(Total), Total < 100 ->
        retract(haveE(Nama,Jumlah)), 
        Jumlah1 is Jumlah + 1, 
        asserta(haveE(Nama,Jumlah1)),
        retract(total(Total)),
        Total1 is Total + 1,
        asserta(total(Total1))).

addToInventory(Nama) :-
    (total(Total), Total < 100 ->
        retract(haveA(Nama,Jumlah)), 
        Jumlah1 is Jumlah + 1, 
        asserta(haveA(Nama,Jumlah1)),
        retract(total(Total)),
        Total1 is Total + 1,
        asserta(total(Total1))).

/* menghapus item dari inventory */
delFromInventory(Nama) :-
    retract(haveA(Nama,Jumlah)),
    Jumlah1 is Jumlah - 1,
    asserta(haveA(Nama,Jumlah1)),
    retract(total(Total)),
    Total1 is Total + 1,
    asserta(total(Total1)).

delFromInventory(Nama) :-
    retract(haveH(Nama,Jumlah)),
    Jumlah1 is Jumlah - 1,
    asserta(haveH(Nama,Jumlah1)),
    retract(total(Total)),
    Total1 is Total + 1,
    asserta(total(Total1)).

delFromInventory(Nama) :-
    retract(haveE(Nama,Jumlah)),
    Jumlah1 is Jumlah - 1,
    asserta(haveE(Nama,Jumlah1)),
    retract(total(Total)),
    Total1 is Total + 1,
    asserta(total(Total1)).








