:- dynamic(takeaquest/3).

take_q :-,
 write('Take your quest here!'),nl,
 random(3,4,X),
 random(3,5,Y),
 random(3,6,Z),
 asserta(takequest(X,Y,Z)),
 write('You got'),write(X),write('slime'),
 write('You got'),write(Y),write('goblin'),nl,
 write('You got'),write(Z),write('wolf'),nl,!.