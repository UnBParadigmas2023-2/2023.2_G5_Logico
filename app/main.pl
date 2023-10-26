:- initialization(main).

:- set_prolog_flag(verbose, silent).
:- style_check(-singleton).

:- dynamic(max_jogos_por_pagina/1).
max_jogos_por_pagina(50).

:- dynamic(total_paginas/1).
total_paginas(0).

main :- 
    consult('./data/dataManager.pl'), 
    carregar_dados('./data/DadosJogos.csv'), 
    menu.

menu :-
    writeln("Bem-vindo ao Sistema de Recomendação de Jogos!"),
    writeln("Escolha uma opção:"),
    writeln("---------------------------------------"),
    writeln("|0. | Exemplo de busca                |"),
    writeln("---------------------------------------"),
    writeln("|1. | Recomendar jogos por nome       |"),
    writeln("---------------------------------------"),
    writeln("|2. | Recomendar jogos por plataforma |"),
    writeln("---------------------------------------"),
    writeln("|3. | Recomendar jogos por ano        |"),
    writeln("---------------------------------------"),
    writeln("|4. | Recomendar jogos por gênero     |"),
    writeln("---------------------------------------"),
    writeln("|5. | Recomendar jogos por publicadora|"),
    writeln("---------------------------------------"),
    writeln("|6. | Busca personalizada             |"),
    writeln("---------------------------------------"),
    writeln("|7. | Sair                            |"),
    writeln("---------------------------------------"),
    read(Opcao),
    (
        Opcao =:= 0 -> writeln('Você está buscando jogos do ano 2010, no estilo de Plataforma'), exemplo_busca;
        Opcao =:= 1 -> recomendar_por_nome;
        Opcao =:= 2 -> recomendar_por_plataforma;
        Opcao =:= 3 -> recomendar_por_ano;
        Opcao =:= 4 -> recomendar_por_genero;
        Opcao =:= 5 -> recomendar_por_publicadora; 
        Opcao =:= 6 -> busca_personalizada;     
        Opcao =:= 7 -> writeln("Obrigado por usar o Sistema de Recomendação de Jogos!"), halt;
        writeln("Opção inválida. Tente novamente."),
        menu
    ).

exemplo_busca :-
    jogo(_, Nome, Plataforma, 2010, 'Platform', _),
    formatar_jogo(Nome, Plataforma, 2010, 'Platform'),
    fail.
exemplo_busca :- menu.

recomendar_por_nome :-
    writeln("Digite o nome do jogo que você está procurando:"),
    read(Find),
    listar_jogos_por_nome(Find).

recomendar_por_plataforma :-
    writeln("Digite a plataforma dos jogos que você deseja (coloque aspas simples no começo e no final):"),
    read(Plataforma),
    listar_jogos_por_plataforma(Plataforma).

recomendar_por_ano :-
    writeln("Digite o ano dos jogos que você está interessado:"),
    read(Ano),
    listar_jogos_por_ano(Ano).

recomendar_por_genero :-
    writeln("Digite o gênero dos jogos que você está interessado:"),
    read(Genero),
    listar_jogos_por_genero(Genero).

recomendar_por_publicadora :-
    writeln("Digite a publicadora dos jogos que você está interessado:"),
    read(Publicadora),
    listar_jogos_por_publicadora(Publicadora).

busca_personalizada :-
    writeln("Digite a plataforma dos jogos que você deseja:"),
    read(plat),
    writeln("Digite o ano dos jogos que você está interessado:"),
    read(year),
    writeln("Digite o gênero dos jogos que você está interessado:"),
    read(gender),
    listar_jogos_personalizados(plat, year, gender).

listar_jogos_por_nome(Find) :-
    max_jogos_por_pagina(MaxPorPagina),
    findall(jogo(Nome, Plataforma, Ano, Genero), 
            (jogo(_, Nome, Plataforma, Ano, Genero, _), atom_concat(' ', Nome, Find)),
            Jogos),
    paginar_e_listar_jogos(Jogos, MaxPorPagina).

listar_jogos_por_plataforma(Plataforma) :-
    max_jogos_por_pagina(MaxPorPagina),
    findall(jogo(Nome, Plataforma, Ano, Genero), 
            jogo(_, Nome, Plataforma, Ano, Genero, _),
            Jogos),
    paginar_e_listar_jogos(Jogos, MaxPorPagina).

listar_jogos_por_ano(Ano) :-
    max_jogos_por_pagina(MaxPorPagina),
    findall(jogo(Nome, Plataforma, Ano, Genero), 
            jogo(_, Nome, Plataforma, Ano, Genero, _),
            Jogos),
    paginar_e_listar_jogos(Jogos, MaxPorPagina).

listar_jogos_por_genero(Genero) :-
    max_jogos_por_pagina(MaxPorPagina),
    findall(jogo(Nome, Plataforma, Ano, Genero), 
            jogo(_, Nome, Plataforma, Ano, Genero, _),
            Jogos),
    paginar_e_listar_jogos(Jogos, MaxPorPagina).

    listar_jogos_por_publicadora(Publicadora) :-
        max_jogos_por_pagina(MaxPorPagina),
        findall(jogo(Nome, Plataforma, Ano, Genero), 
                jogo(_, Nome, Plataforma, Ano, Genero, Publicadora),
                Jogos),
        paginar_e_listar_jogos(Jogos, MaxPorPagina).

listar_jogos_personalizados(Plataforma, Ano, Genero) :-
    max_jogos_por_pagina(MaxPorPagina),
    findall(jogo(Nome, Plataforma, Ano, Genero), 
            jogo(_, Nome, Plataforma, Ano, Genero, _),
            Jogos),
    paginar_e_listar_jogos(Jogos, MaxPorPagina).

paginar_e_listar_jogos(Jogos, MaxPorPagina) :-
    length(Jogos, Total),
    max_jogos_por_pagina(MaxPorPagina),
    calcular_total_paginas(Total, MaxPorPagina),
    paginar_e_listar_jogos(Jogos, Total, MaxPorPagina, 0).

calcular_total_paginas(Total, MaxPorPagina) :-
    TotalPaginas is ceil(Total / MaxPorPagina),
    asserta(total_paginas(TotalPaginas)).

paginar_e_listar_jogos(_, 0, _, _) :-
    writeln("Fim da lista de jogos.").

% Função para paginar e listar jogos
paginar_e_listar_jogos(Jogos, Total, MaxPorPagina, Pagina) :-
    total_paginas(TotalPaginas),
    PaginaAtual is Pagina + 1,
    sublist(Jogos, MaxPorPagina, JogosPagina, Resto),
    listar_jogos(JogosPagina),
    (Total > MaxPorPagina ->
        format("Página ~d de ~d~n~n", [PaginaAtual, TotalPaginas]),
        writeln("Digite '1' para retornar ao menu ou '2' para avançar para a próxima página.");
    true
    ),
    read(Opcao),
    (Opcao =:= 1 -> menu;
    Opcao =:= 2 -> paginar_e_listar_jogos(Resto, Total - MaxPorPagina, MaxPorPagina, PaginaAtual);
    true
    ).

listar_jogos([]).
listar_jogos([jogo(Nome, Plataforma, Ano, Genero) | Resto]) :-
    formatar_jogo(Nome, Plataforma, Ano, Genero),
    listar_jogos(Resto).

% Função para formatar jogos
formatar_jogo(Nome, Plataforma, Ano, Genero) :-
    write('| '),
    format('~w', [Nome]),
    espacos_em_branco(Nome, 130),
    write(' | '),
    format('~w', [Plataforma]),
    espacos_em_branco(Plataforma, 20),
    write(' | '),
    format('~w', [Ano]),
    espacos_em_branco(Ano, 5),
    write(' | '),
    format('~w', [Genero]),
    espacos_em_branco(Genero, 30),
    writeln(' |'),
    writeln('------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------').

espacos_em_branco(Texto, Tamanho) :-
    atom_length(Texto, Comprimento),
    Espacos is Tamanho - Comprimento,
    tab(Espacos).

sublist(L, N, Prefix, Suffix) :-
    length(Prefix, N),
    append(Prefix, Suffix, L).
