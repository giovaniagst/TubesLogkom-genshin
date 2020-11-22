/* File main.pl */

:- include('map.pl')
:- include('player.pl')

mulai:-
    write('       ____  U _____ u _   _    ____     _   _               _   _ '), nl.
    write('U /"___|u | ___"|/| \ |"|  / __"| u | | | |     ___     | \ |"|   '), nl.
    write('\| |  _ / |  _|" <|  \| |><\___ \/ /| |_| |\   |_"_|   <|  \| |>   '), nl.
    write(' | |_| |  | |___ U| |\  |u u___) | U|  _  |u    | |    U| |\  |u  '), nl.
    write('  \____|  |_____| |_| \_|  |____/>> |_| |_|   U/| |\u   |_| \_|  '), nl.
    write(' _)(|_   <<   >> ||   \,-.)(  (__)//   \.-,_|___|_,-.||   \,-. '), nl.
    write('(__)__) (__) (__)(_")  (_/(__)    (_") ("_)\_)-' '-(_/ (_")  (_/ '), nl.
    write(''), nl.
    write(''), nl.
    write("Let's play the game"), nl.
    write(''), nl.
    write(''), nl.
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.
    write('%                              GENSHIN ADVENTURE                               %'), nl.
    write('% 1. start  : untuk memulai permainan                                          %'), nl.
    write('% 2. map    : untuk menampilkan peta                                           %'), nl.
    write('% 3. status : untuk menampilkan kondisi terkini pemain                         %'), nl.
    write('% 4. w      : gerak ke atas sebanyak 1 langkah                                 %'), nl.
    write('% 5. s      : gerak ke bawah sebnayak 1 langkah                                %'), nl.
    write('% 6. a      : gerak ke kiri sebanyak 1 langkah                                 %'), nl.
    write('% 7. d      : gerak ke kanan sebanyak 1 langkah                                %'), nl.
    write('% 8. Status : menampilkan status pemain                                        %'), nl.
    write('% 9. help   : menampilkan bantuan                                              %'), nl.
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.

start:-
    choose_character.

quit :-
    halt, !.

help :-
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.
    write('%                              GENSHIN ADVENTURE                               %'), nl.
    write('% 1. start  : untuk memulai permainan                                          %'), nl.
    write('% 2. map    : untuk menampilkan peta                                           %'), nl.
    write('% 3. status : untuk menampilkan kondisi terkini pemain                         %'), nl.
    write('% 4. w      : gerak ke atas sebanyak 1 langkah                                 %'), nl.
    write('% 5. s      : gerak ke bawah sebnayak 1 langkah                                %'), nl.
    write('% 6. a      : gerak ke kiri sebanyak 1 langkah                                 %'), nl.
    write('% 7. d      : gerak ke kanan sebanyak 1 langkah                                %'), nl.
    write('% 8. Status : menampilkan status pemain                                        %'), nl.
    write('% 9. help   : menampilkan bantuan                                              %'), nl.
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.

map :-
    write("You also got a map! Let's see…"), nl.
    write('################'), nl.
    write('#P-------------#'), nl.
    write('#--------------#'), nl.
    write('#------Q-------#'), nl.
    write('#--------------#'), nl.
    write('#-------#---Q--#'), nl.
    write('#-------#------#'), nl.
    write('#----#######---#'), nl.
    write('#---------S----#'), nl.
    write('#--------------#'), nl.
    write('#--------------#'), nl.
    write('#--Q-----------#'), nl.
    write('#--------------#'), nl.
    write('#--------------#'), nl.
    write('#------#-------#'), nl.
    write('#---####---Q---#'), nl.
    write('#----D-#-------#'), nl.
    write('#--------------#'), nl.
    write('################'), nl.