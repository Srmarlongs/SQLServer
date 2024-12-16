-- Criação do banco de dados
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

-- Tabela Álbum
CREATE TABLE Album (
    AlbumID INT PRIMARY KEY IDENTITY(1,1),    -- ID do Álbum
    Titulo NVARCHAR(100) NOT NULL,             -- Título do Álbum
    Ano INT NOT NULL,                          -- Ano de Lançamento
    DuracaoTotal INT,                          -- Duração Total em minutos
    ArtistaID INT,                             -- Relacionamento com o Artista
    FOREIGN KEY (ArtistaID) REFERENCES Artista(ArtistaID)  -- Chave estrangeira com Artista
);
GO

-- Tabela Música
CREATE TABLE Musica (
    MusicaID INT PRIMARY KEY IDENTITY(1,1),   -- ID da Música
    Titulo NVARCHAR(100) NOT NULL,             -- Título da Música
    Duracao INT,                               -- Duração da Música em minutos
    AlbumID INT,                               -- Relacionamento com o Álbum
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)  -- Chave estrangeira com Álbum
);
GO

-- Tabela ListaMúsicas
CREATE TABLE ListaMusicas (
    ListaMusicaID INT PRIMARY KEY IDENTITY(1,1), -- ID da relação
    MusicaID INT,                                  -- Relacionamento com Música
    AlbumID INT,                                   -- Relacionamento com Álbum
    FOREIGN KEY (MusicaID) REFERENCES Musica(MusicaID),  -- Chave estrangeira com Música
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)     -- Chave estrangeira com Álbum
);
GO

-- Tabela ListaArtistas
CREATE TABLE ListaArtistas (
    ListaArtistaID INT PRIMARY KEY IDENTITY(1,1), -- ID da relação
    ArtistaID INT,                                 -- Relacionamento com Artista
    AlbumID INT,                                   -- Relacionamento com Álbum
    FOREIGN KEY (ArtistaID) REFERENCES Artista(ArtistaID),  -- Chave estrangeira com Artista
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)         -- Chave estrangeira com Álbum
);
GO


-- Inserção de Dados

-- Inserir dados na tabela Artista
INSERT INTO Artista (Nome, Nacionalidade)
VALUES 
    ('John Doe', 'Americano'),
    ('Maria Souza', 'Brasileira'),
    ('Luca Di Biase', 'Italiano');
GO

-- Inserir dados na tabela Álbum
INSERT INTO Album (Titulo, Ano, DuracaoTotal, ArtistaID)
VALUES
    ('The Best Hits', 2023, 45, 1),
    ('Clássicos do Samba', 2022, 60, 2),
    ('Viva la Vida', 2024, 50, 3);
GO

-- Inserir dados na tabela Música
INSERT INTO Musica (Titulo, Duracao, AlbumID)
VALUES
    ('Song One', 3, 1),
    ('Song Two', 4, 1),
    ('Samba do Brasil', 5, 2),
    ('Viva la Vida', 4, 3);
GO

-- Inserir dados na tabela ListaMúsicas
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


-- Consultas para Visualização de Dados

-- Consultar todos os Artistas
SELECT * 
FROM Artista;


-- Consultar todos os Álbuns
SELECT * 
FROM Album;


-- Consultar todos as Músicas
SELECT * 
FROM Musica;


-- Consultar as Músicas de um Álbum específico
SELECT 
    m.Titulo AS MusicaTitulo, 
    m.Duracao AS MusicaDuracao
FROM Musica m
WHERE m.AlbumID = 1;


-- Consultar os Artistas de um Álbum específico
SELECT 
    ar.Nome AS ArtistaNome
FROM Artista ar
JOIN ListaArtistas la ON ar.ArtistaID = la.ArtistaID
WHERE la.AlbumID = 1;

