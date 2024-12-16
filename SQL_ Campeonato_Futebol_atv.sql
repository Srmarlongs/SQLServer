-- Selecionando o banco de dados
USE campeonato_futebol;
GO

-- Tabela para Est�dios
CREATE TABLE Estadio (
    id INT IDENTITY(1,1) PRIMARY KEY,           -- Identificador �nico do est�dio
    nome_estadio VARCHAR(255),                   -- Nome do est�dio
    endereco_estadio TEXT                        -- Endere�o do est�dio
);
GO

-- Tabela para Campeonatos
CREATE TABLE Campeonato (
    id INT IDENTITY(1,1) PRIMARY KEY,           -- Identificador �nico do campeonato
    nome_campeonato VARCHAR(255),                -- Nome do campeonato
    ano INT,                                     -- Ano do campeonato
    partidas TEXT,                               -- Informa��es sobre as partidas (pode ser uma lista)
    tabela_classificacao TEXT                    -- Informa��es sobre a classifica��o dos times
);
GO

-- Tabela para Partidas
CREATE TABLE Partida (
    id INT IDENTITY(1,1) PRIMARY KEY,           -- Identificador �nico da partida
    data_partida DATE,                          -- Data da partida
    estado VARCHAR(50),                         -- Estado da partida (ex: Finalizado, Agendada)
    time_mandante VARCHAR(255),                 -- Nome do time mandante
    time_visitante VARCHAR(255),                -- Nome do time visitante
    id_campeonato INT,                          -- Relacionamento com a tabela Campeonato
    FOREIGN KEY (id_campeonato) REFERENCES Campeonato(id)  -- Chave estrangeira que referencia o campeonato
);
GO

-- Tabela para Times
CREATE TABLE Time (
    id INT IDENTITY(1,1) PRIMARY KEY,           -- Identificador �nico do time
    nome_time VARCHAR(255),                     -- Nome do time
    id_estadio INT,                             -- Relacionamento com a tabela Est�dio
    jogadores TEXT,                             -- Lista de jogadores do time
    classificacao INT,                          -- Classifica��o do time no campeonato
    FOREIGN KEY (id_estadio) REFERENCES Estadio(id)  -- Chave estrangeira que referencia o est�dio
);
GO

-- Tabela para Jogadores
CREATE TABLE Jogador (
    id INT IDENTITY(1,1) PRIMARY KEY,           -- Identificador �nico do jogador
    nome VARCHAR(255),                          -- Nome do jogador
    data_nascimento DATE,                       -- Data de nascimento do jogador
    genero VARCHAR(50),                         -- G�nero do jogador
    altura FLOAT,                               -- Altura do jogador
    id_time INT,                                -- Relacionamento com a tabela Time
    capitao BIT DEFAULT 0,                      -- Indica se o jogador � o capit�o do time (0 ou 1)
    FOREIGN KEY (id_time) REFERENCES Time(id)   -- Chave estrangeira que referencia o time
);
GO

-- Tabela para relacionar Partidas e Times
CREATE TABLE PartidasOcorridas (
    id_partida INT,                             -- Relacionamento com a tabela Partida
    id_time INT,                                -- Relacionamento com a tabela Time
    PRIMARY KEY (id_partida, id_time),          -- Chave prim�ria composta pelas colunas id_partida e id_time
    FOREIGN KEY (id_partida) REFERENCES Partida(id),  -- Chave estrangeira que referencia a partida
    FOREIGN KEY (id_time) REFERENCES Time(id)   -- Chave estrangeira que referencia o time
);
GO

-- Inserir dados na tabela Est�dio
INSERT INTO Estadio (nome_estadio, endereco_estadio)
VALUES
    ('Maracan�', 'Av. Maracan�, Rio de Janeiro, RJ'),
    ('Arena Corinthians', 'Rua dos Tr�s Irm�os, S�o Paulo, SP'),
    ('Mineir�o', 'Av. Ant�nio Abrah�o Caram, Belo Horizonte, MG'),
    ('Arena da Baixada', 'Rua Buenos Aires, Curitiba, PR');
GO

-- Inserir dados na tabela Campeonato
INSERT INTO Campeonato (nome_campeonato, ano, partidas, tabela_classificacao)
VALUES
    ('Campeonato Brasileiro', 2024, 'Partidas da Primeira Fase', 'Classifica��o atualizada'),
    ('Copa do Mundo', 2024, 'Fase de Grupos', 'Top 4 Times'),
    ('Copa Libertadores', 2024, 'Fase de Grupos', 'Classifica��o por grupo'),
    ('Campeonato Carioca', 2024, 'Partidas da Fase Final', 'Classifica��o por fases');
GO

-- Inserir dados na tabela Partida
INSERT INTO Partida (data_partida, estado, time_mandante, time_visitante, id_campeonato)
VALUES
    ('2024-12-10', 'Finalizado', 'Flamengo', 'S�o Paulo', 1),
    ('2024-12-11', 'Agendada', 'Atl�tico Mineiro', 'Vasco', 1),
    ('2024-12-12', 'Finalizado', 'Barcelona', 'Real Madrid', 2),
    ('2024-12-13', 'Agendada', 'Palmeiras', 'Gr�mio', 3);
GO

-- Inserir dados na tabela Time
INSERT INTO Time (nome_time, id_estadio, jogadores, classificacao)
VALUES
    ('Flamengo', 1, 'Gabigol, Arrascaeta, Everton Ribeiro', 1),
    ('S�o Paulo', 2, 'Calleri, Luciano, Alisson', 2),
    ('Atl�tico Mineiro', 3, 'Hulk, Keno, Nathan Silva', 3),
    ('Vasco', 4, 'Nen�, Figueiredo, Ben�tez', 4);
GO

-- Inserir dados na tabela Jogador
INSERT INTO Jogador (nome, data_nascimento, genero, altura, id_time, capitao)
VALUES
    ('Gabigol', '1996-08-30', 'Masculino', 1.75, 1, 1),
    ('Arrascaeta', '1994-06-23', 'Masculino', 1.73, 1, 0),
    ('Hulk', '1986-07-25', 'Masculino', 1.85, 3, 1),
    ('Luciano', '1993-05-24', 'Masculino', 1.79, 2, 0);
GO

-- Inserir dados na tabela PartidasOcorridas
INSERT INTO PartidasOcorridas (id_partida, id_time)
VALUES
    (1, 1),  -- Flamengo jogou na primeira partida
    (1, 2),  -- S�o Paulo jogou na primeira partida
    (2, 3),  -- Atl�tico Mineiro jogou na segunda partida
    (2, 4);  -- Vasco jogou na segunda partida
GO

-- Consultar os dados inseridos nas tabelas para visualiza��o

-- Consultar todos os est�dios
SELECT * 
FROM Estadio;


-- Consultar todos os campeonatos
SELECT * 
FROM Campeonato;


-- Consultar todas as partidas
SELECT * 
FROM Partida;


-- Consultar todos os times
SELECT *
FROM Time;


-- Consultar todos os jogadores
SELECT * 
FROM Jogador;


-- Consultar todas as partidas ocorridas
SELECT * 
FROM PartidasOcorridas;

