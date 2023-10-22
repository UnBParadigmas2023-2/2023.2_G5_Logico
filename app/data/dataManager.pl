:- use_module(library(csv)).
:- dynamic jogo/6.

carregar_dados(CSVFile) :-
    csv_read_file(CSVFile, Rows, [functor(row)]),
    assert_dados(Rows).

assert_dados([]).
assert_dados([Row | Rest]) :-
    Row =.. [row | [Rank, Nome, Plataforma, Ano, Genero, Publicador]],
    assert(jogo(Rank, Nome, Plataforma, Ano, Genero, Publicador)),
    assert_dados(Rest).
