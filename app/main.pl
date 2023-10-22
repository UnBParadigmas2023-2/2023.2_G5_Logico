:- initialization(main). 

main :- 
    consult('./data/dataManager.pl'), 
    carregar_dados('./data/DadosJogos.csv'), 
    menu. 

menu :-
   jogo(_, Nome, _, 2010, 'Platform', _),
    write(Nome), nl,
    fail.


