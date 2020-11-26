/* File main.pl */

:- include('player.pl').
:- include('inventory.pl').
:- include('map.pl').



start :-
    playing(_),!.

start:-
   /* nanti ada tulisan genshin */
    write(''), nl,
    write(''), nl,
    write('Lets play the game'), nl,
    write(''), nl,
    write(''), nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
    write('%                              GENSHIN ADVENTURE                               %'), nl,
    write('% 1. start  : untuk memulai permainan                                          %'), nl,
    write('% 2. map    : untuk menampilkan peta                                           %'), nl,
    write('% 3. status : untuk menampilkan kondisi terkini pemain                         %'), nl,
    write('% 4. w      : gerak ke atas sebanyak 1 langkah                                 %'), nl,
    write('% 5. s      : gerak ke bawah sebnayak 1 langkah                                %'), nl,
    write('% 6. a      : gerak ke kiri sebanyak 1 langkah                                 %'), nl,
    write('% 7. d      : gerak ke kanan sebanyak 1 langkah                                %'), nl,
    write('% 8. Status : menampilkan status pemain                                        %'), nl,
    write('% 9. help   : menampilkan bantuan                                              %'), nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.

start:-
    choose_character,
    mulai, player_place.

quit :-
    halt, !.

help :-
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
    write('%                              GENSHIN ADVENTURE                               %'), nl,
    write('% 1. start  : untuk memulai permainan                                          %'), nl,
    write('% 2. map    : untuk menampilkan peta                                           %'), nl,
    write('% 3. status : untuk menampilkan kondisi terkini pemain                         %'), nl,
    write('% 4. w      : gerak ke atas sebanyak 1 langkah                                 %'), nl,
    write('% 5. s      : gerak ke bawah sebnayak 1 langkah                                %'), nl,
    write('% 6. a      : gerak ke kiri sebanyak 1 langkah                                 %'), nl,
    write('% 7. d      : gerak ke kanan sebanyak 1 langkah                                %'), nl,
    write('% 8. Status : menampilkan status pemain                                        %'), nl,
    write('% 9. help   : menampilkan bantuan                                              %'), nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.

inventory :-
    show_inventory.
/*status :-
    player_status.*/

/*inventory :-
    write('This is your inventory'), nl,
    character(Job),
    (Job == swordman ->
        inventory_sowrdman,
        have(Nama,Jumlah),
        (Jumlah =\= 0 ->
            write(Jumlah), write(Nama), nl);
    Job == archer ->
        inventory_archer,
        have(Nama,Jumlah),
        (Jumlah =\= 0 ->
            write(Jumlah), write(Nama), nl);
    Job == sorcerer ->
        inventory_sorcerer,
        have(Nama,Jumlah),
        (Jumlah =\= 0 ->
            write(Jumlah), write(Nama), nl)).*/
