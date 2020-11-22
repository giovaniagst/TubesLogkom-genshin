/* Untuk player.pl */

/* fakta untuk player */


choose_character :-
    write('Welcome to GENSHIN ADVENTURE. Choose your character'), nl.
    write('1. Swordman'), nl.
    write('2. Archer'), nl.
    write('3. Sorcerer'), nl.
    read(X), nl.
    (X =:= 1 -> write('Welcome to the adventure, Swordman!'), nl, write('You got a Wooden Sword, Wooden Armor, and 5 Health Potion'), nl, write("Let's finish the job!"), nl;
    X =:= 2 -> write('Welcome to the adventure, Archer!'), nl, write('You got a Wooden Bow, Wooden Armor, and 5 Health Potion'), nl, write("Let's finish the job!"), nl;
    X =:= 3 -> write('Welcome to the adventure, Sorcerer!'), nl, write('You got a Magic Book, Wooden Armor, and 5 Health Potion'), nl, write("Let's finish the job!"), nl;).
