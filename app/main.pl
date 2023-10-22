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
    writeln("4. Busca personalizada"),
    writeln("5. Sair"),
    read(Opcao),
    (
        Opcao =:= 0 -> exemplo_busca;
        Opcao =:= 1 -> recomendar_por_nome;
        Opcao =:= 2 -> recomendar_por_plataforma;
        Opcao =:= 3 -> recomendar_por_ano;
        Opcao =:= 4 -> busca_personalizada;      
        Opcao =:= 5 -> writeln("Obrigado por usar o Sistema de Recomendação de Jogos!"), halt;
        writeln("Opção inválida. Tente novamente."),
        menu
    ).

exemplo_busca :-
    jogo(_, Nome, _, 2010, 'Platform', _),
    write(Nome), nl,
    fail.
    menu.

recomendar_por_nome :-
    writeln("Digite o nome do jogo que você está procurando:"),
    read(Find),
    %jogo(_, Nome, _, _, _, _),
    %sub_atom(Nome, 0, _, _, Find),
    %writeln(Nome),
    %fail.
    menu.

recomendar_por_plataforma :-
    writeln("Digite a plataforma dos jogos que você deseja:"),
    read(Plataforma),
    menu.

recomendar_por_ano :-
    writeln("Digite o ano dos jogos que você está interessado:"),
    read(Ano),
    menu.

busca_personalizada :-
    writeln("Digite a plataforma dos jogos que você deseja:"),
    read(plat),
    writeln("Digite o ano dos jogos que você está interessado:"),
    read(year),
    writeln("Digite o genero dos jogos que você está interessado:"),
    read(gender),
    menu.

