:- initialization(main).

main :- 
    consult('./data/dataManager.pl'), 
    carregar_dados('./data/DadosJogos.csv'), 
    menu.

menu :-
    writeln("Bem-vindo ao Sistema de Recomendação de Jogos!"),
    writeln("Escolha uma opção:"),
    writeln("0. Exemplo de busca"),
    writeln("1. Recomendar jogos por nome"),
    writeln("2. Recomendar jogos por plataforma"),
    writeln("3. Recomendar jogos por ano"),
    writeln("4. Recomendar jogos por genero"),
    writeln("5. Busca personalizada"),
    writeln("6. Sair"),
    read(Opcao),
    (
        Opcao =:= 0 -> writeln('Você está buscando jogos do ano 2010, no estilo de Plataforma'),exemplo_busca;
        Opcao =:= 1 -> recomendar_por_nome;
        Opcao =:= 2 -> recomendar_por_plataforma;
        Opcao =:= 3 -> recomendar_por_ano;
        Opcao =:= 4 -> recomendar_por_genero;
        Opcao =:= 5 -> busca_personalizada;      
        Opcao =:= 6 -> writeln("Obrigado por usar o Sistema de Recomendação de Jogos!"), halt;
        writeln("Opção inválida. Tente novamente."),
        menu
    ).
exemplo_busca :-
    jogo(_, Nome, Video, 2010, 'Platform', _),
    write(Nome),write(' - '),write(Video), nl,
    fail.
exemplo_busca :- menu.


recomendar_por_nome :-
    writeln("Digite o nome do jogo que você está procurando:"),
    read(Find),
    %jogo(_, Nome, _, _, _, _),
    %sub_atom(Nome, 0, _, _, Find),
    %writeln(Nome),
    %fail.
    menu.

recomendar_por_plataforma :-
    writeln("Digite a plataforma dos jogos que você deseja(Coloque aspas simples no começo e no final):"),
    read(Plataforma),
    jogo(_, Nome, Plataforma, Ano, Genero, _),
    write(Nome), write(' - '), write(Plataforma), write(' - '), write(Ano), write(' - '), write(Genero), nl,
    fail.

recomendar_por_ano :-
    writeln("Digite o ano dos jogos que você está interessado:"),
    read(Ano),jogo(_, Nome, Plataforma, Ano, Genero, _),
    write(Nome), write(' - '), write(Plataforma), write(' - '), write(Ano), write(' - '), write(Genero), nl,
    fail.

recomendar_por_genero :-
    writeln("Digite o genero dos jogos que você está interessado:"),
    read(Genero),jogo(_, Nome, Plataforma, Ano, Genero, _),
    write(Nome), write(' - '), write(Plataforma), write(' - '), write(Ano), write(' - '), write(Genero), nl,
    fail.

busca_personalizada :-
    writeln("Digite a plataforma dos jogos que você deseja:"),
    read(plat),
    writeln("Digite o ano dos jogos que você está interessado:"),
    read(year),
    writeln("Digite o genero dos jogos que você está interessado:"),
    read(gender),
    menu.


