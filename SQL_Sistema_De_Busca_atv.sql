-- Cria��o do banco de dados
CREATE DATABASE SistemaDeBusca_atv;
GO

-- Selecionando o banco de dados
USE SistemaDeBusca_atv;
GO

-- Tabela Artista
CREATE TABLE Artista (
    ArtistaID INT PRIMARY KEY IDENTITY(1,1),  -- ID do Artista
    Nome NVARCHAR(100) NOT NULL,               -- Nome do Artista
    Nacionalidade NVARCHAR(50) NOT NULL       -- Nacionalidade do Artista
);
GO

-- Tabela �lbum
CREATE TABLE Album (
    AlbumID INT PRIMARY KEY IDENTITY(1,1),    -- ID do �lbum
    Titulo NVARCHAR(100) NOT NULL,             -- T�tulo do �lbum
    Ano INT NOT NULL,                          -- Ano de Lan�amento
    DuracaoTotal INT,                          -- Dura��o Total em minutos
    ArtistaID INT,                             -- Relacionamento com o Artista
    FOREIGN KEY (ArtistaID) REFERENCES Artista(ArtistaID)  -- Chave estrangeira com Artista
);
GO

-- Tabela M�sica
CREATE TABLE Musica (
    MusicaID INT PRIMARY KEY IDENTITY(1,1),   -- ID da M�sica
    Titulo NVARCHAR(100) NOT NULL,             -- T�tulo da M�sica
    Duracao INT,                               -- Dura��o da M�sica em minutos
    AlbumID INT,                               -- Relacionamento com o �lbum
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)  -- Chave estrangeira com �lbum
);
GO

-- Tabela ListaM�sicas
CREATE TABLE ListaMusicas (
    ListaMusicaID INT PRIMARY KEY IDENTITY(1,1), -- ID da rela��o
    MusicaID INT,                                  -- Relacionamento com M�sica
    AlbumID INT,                                   -- Relacionamento com �lbum
    FOREIGN KEY (MusicaID) REFERENCES Musica(MusicaID),  -- Chave estrangeira com M�sica
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)     -- Chave estrangeira com �lbum
);
GO

-- Tabela ListaArtistas
CREATE TABLE ListaArtistas (
    ListaArtistaID INT PRIMARY KEY IDENTITY(1,1), -- ID da rela��o
    ArtistaID INT,                                 -- Relacionamento com Artista
    AlbumID INT,                                   -- Relacionamento com �lbum
    FOREIGN KEY (ArtistaID) REFERENCES Artista(ArtistaID),  -- Chave estrangeira com Artista
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)         -- Chave estrangeira com �lbum
);
GO


-- Inser��o de Dados

-- Inserir dados na tabela Artista
INSERT INTO Artista (Nome, Nacionalidade)
VALUES 
    ('John Doe', 'Americano'),
    ('Maria Souza', 'Brasileira'),
    ('Luca Di Biase', 'Italiano');
GO

-- Inserir dados na tabela �lbum
INSERT INTO Album (Titulo, Ano, DuracaoTotal, ArtistaID)
VALUES
    ('The Best Hits', 2023, 45, 1),
    ('Cl�ssicos do Samba', 2022, 60, 2),
    ('Viva la Vida', 2024, 50, 3);
GO

-- Inserir dados na tabela M�sica
INSERT INTO Musica (Titulo, Duracao, AlbumID)
VALUES
    ('Song One', 3, 1),
    ('Song Two', 4, 1),
    ('Samba do Brasil', 5, 2),
    ('Viva la Vida', 4, 3);
GO

-- Inserir dados na tabela ListaM�sicas
INSERT INTO ListaMusicas (MusicaID, AlbumID)
VALUES
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 3);
GO

-- Inserir dados na tabela ListaArtistas
INSERT INTO ListaArtistas (ArtistaID, AlbumID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);
GO


-- Consultas para Visualiza��o de Dados

-- Consultar todos os Artistas
SELECT * 
FROM Artista;


-- Consultar todos os �lbuns
SELECT * 
FROM Album;


-- Consultar todos as M�sicas
SELECT * 
FROM Musica;


-- Consultar as M�sicas de um �lbum espec�fico
SELECT 
    m.Titulo AS MusicaTitulo, 
    m.Duracao AS MusicaDuracao
FROM Musica m
WHERE m.AlbumID = 1;


-- Consultar os Artistas de um �lbum espec�fico
SELECT 
    ar.Nome AS ArtistaNome
FROM Artista ar
JOIN ListaArtistas la ON ar.ArtistaID = la.ArtistaID
WHERE la.AlbumID = 1;

