/* File main.pl */

:- include('player.pl').
:- include('inventory.pl').
:- include('map.pl').

:- dynamic(playing/1).


start :-
    playing(_),
    write('You can only start the game once'),nl,!.

start:-
    write('%%%%%%%%%      %%%%%%%%%%%%    %%%%%         %%%    %%%%%%%%%%%     %%%      %%%   %%%%%%%%%   %%%%%         %%%'), nl,
    write('%%%%%%%%%%     %%%%%%%%%%%%    %%% %%%       %%%   %%%%%%%%%%%%%    %%%      %%%   %%%%%%%%%   %%% %%%       %%%'), nl,
    write('%%      %%     %%%             %%%  %%%      %%%    %%%%            %%%      %%%      %%%      %%%  %%%      %%%'), nl,
    write('%%             %%%             %%%   %%%     %%%      %%%%%         %%%      %%%      %%%      %%%   %%%     %%%'), nl,
    write('%%    %%%%%    %%%%%%%%%%%%    %%%    %%%    %%%        %%%%%%      %%%%%%%%%%%%      %%%      %%%    %%%    %%%'), nl,
    write('%%    %%%%%%   %%%%%%%%%%%%    %%%     %%%   %%%           %%%%%    %%%%%%%%%%%%      %%%      %%%     %%%   %%%'), nl,
    write('%%        %%   %%%             %%%      %%%  %%%             %%%%%  %%%      %%%      %%%      %%%      %%%  %%%'), nl,
    write('%%        %%   %%%             %%%       %%% %%%            %%%%%%  %%%      %%%      %%%      %%%       %%% %%%'), nl,
    write('%%%%%%%%%%%    %%%%%%%%%%%%    %%%        %%%%%%     %%%%%%%%%%%%   %%%      %%%   %%%%%%%%%   %%%        %%%%%%'), nl,
    write('%%%%%%%%%%     %%%%%%%%%%%%    %%%         %%%%%      %%%%%%%%%%    %%%      %%%   %%%%%%%%%   %%%         %%%%%'), nl,
    write(''), nl,
    write(''), nl,
    write('Lets play the game!'), nl,
    write(''), nl,
    write(''), nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
    write('%                              GENSHIN ADVENTURE                                   %'), nl,
    write('% 1.  start     : untuk memulai permainan                                          %'), nl,
    write('% 2.  map       : untuk menampilkan peta                                           %'), nl,
    write('% 3.  status    : untuk menampilkan kondisi terkini pemain                         %'), nl,
    write('% 4.  w         : gerak ke atas sebanyak 1 langkah                                 %'), nl,
    write('% 5.  s         : gerak ke bawah sebnayak 1 langkah                                %'), nl,
    write('% 6.  a         : gerak ke kiri sebanyak 1 langkah                                 %'), nl,
    write('% 7.  d         : gerak ke kanan sebanyak 1 langkah                                %'), nl,
    write('% 8.  shop      : untuk masuk ke shop                                              %'), nl,
    write('% 9.  help      : menampilkan bantuan                                              %'), nl,
    write('% 10. inventory : menampilkan inventory pemain                                     %'), nl,
    write('% 11. quit      : untuk keluar dari permainan                                      %'), nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.

start:-
    asserta(playing(1)),
    choose_character,
    mulai, player_place.

quit :-
    halt, !.

help :-
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
    write('%                              GENSHIN ADVENTURE                                   %'), nl,
    write('% 1.  start     : untuk memulai permainan                                          %'), nl,
    write('% 2.  map       : untuk menampilkan peta                                           %'), nl,
    write('% 3.  status    : untuk menampilkan kondisi terkini pemain                         %'), nl,
    write('% 4.  w         : gerak ke atas sebanyak 1 langkah                                 %'), nl,
    write('% 5.  s         : gerak ke bawah sebnayak 1 langkah                                %'), nl,
    write('% 6.  a         : gerak ke kiri sebanyak 1 langkah                                 %'), nl,
    write('% 7.  d         : gerak ke kanan sebanyak 1 langkah                                %'), nl,
    write('% 8.  shop      : untuk masuk ke shop                                              %'), nl,
    write('% 9.  help      : menampilkan bantuan                                              %'), nl,
    write('% 10. inventory : menampilkan inventory pemain                                     %'), nl,
    write('% 11. quit      : untuk keluar dari permainan                                      %'), nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.

inventory :-
    show_inventory(X).

status :-
    player_status(X).
