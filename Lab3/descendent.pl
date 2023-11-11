child(bridget,caroline).
child(caroline,donna).

descend(X,Y)  :-  child(X,Y).
descend(X,Y)  :-  child(X,Z),
                    child(Z,Y).

descend(X,Y)  :-  child(X,Z_1),
                child(Z_1,Z_2),
                child(Z_2,Y).

descend(X,Y)  :-  child(X,Z_1),
                child(Z_1,Z_2),
                child(Z_2,Z_3),
                child(Z_3,Y).

descend(X,Y)  :-  child(X,Y).
   
descend(X,Y)  :-  child(X,Z),
                descend(Z,Y).

child(anne,bridget).
child(bridget,caroline).
child(caroline,donna).
child(donna,emily).