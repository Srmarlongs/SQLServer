-- Cria��o do banco de dados
CREATE DATABASE Biblioteca_atv;
GO

-- Sele��o do banco de dados
USE Biblioteca_atv;
GO

-- Tabela ClienteBiblioteca
CREATE TABLE ClienteBiblioteca (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),    -- Identificador �nico do cliente
    Nome NVARCHAR(100) NOT NULL,                 -- Nome do cliente
    CPF CHAR(11) NOT NULL UNIQUE,                -- CPF do cliente (�nico)
    Endereco NVARCHAR(200),                      -- Endere�o do cliente
    Telefone NVARCHAR(15),                       -- Telefone do cliente
    EnderecoEletronico NVARCHAR(100),            -- E-mail do cliente
    LimiteReservas INT DEFAULT 0,                -- Limite de reservas permitidas
    LimiteEmprestimos INT DEFAULT 0              -- Limite de empr�stimos permitidos
);
GO

-- Tabela Emprestimo
CREATE TABLE Emprestimo (
    EmprestimoID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador �nico do empr�stimo
    ClienteID INT,                               -- Relacionamento com a tabela ClienteBiblioteca
    DataEmprestimo DATE NOT NULL,                -- Data do empr�stimo
    Estado NVARCHAR(50),                         -- Estado do empr�stimo (ex: Aberto, Fechado)
    FOREIGN KEY (ClienteID) REFERENCES ClienteBiblioteca(ClienteID)  -- Chave estrangeira
);
GO

-- Tabela Item
CREATE TABLE Item (
    ItemID INT PRIMARY KEY IDENTITY(1,1),       -- Identificador �nico do item
    Estado NVARCHAR(50),                         -- Estado do item (ex: Dispon�vel, Emprestado)
    DataAquisicao DATE                           -- Data de aquisi��o do item
);
GO

-- Tabela Reserva
CREATE TABLE Reserva (
    ReservaID INT PRIMARY KEY IDENTITY(1,1),    -- Identificador �nico da reserva
    ClienteID INT,                               -- Relacionamento com a tabela ClienteBiblioteca
    ItemID INT,                                  -- Relacionamento com a tabela Item
    DataReserva DATE NOT NULL,                   -- Data da reserva
    FOREIGN KEY (ClienteID) REFERENCES ClienteBiblioteca(ClienteID),  -- Chave estrangeira
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)  -- Chave estrangeira
);
GO

-- Tabela Titulo
CREATE TABLE Titulo (
    TituloID INT PRIMARY KEY IDENTITY(1,1),     -- Identificador �nico do t�tulo
    Classificacao NVARCHAR(50),                  -- Classifica��o do t�tulo
    Cutter NVARCHAR(50),                         -- Cutter do t�tulo
    TempoEmprestimo INT,                         -- Tempo de empr�stimo em dias
    PalavrasChave NVARCHAR(200)                  -- Palavras-chave associadas ao t�tulo
);
GO

-- Tabela Biblioteca
CREATE TABLE Biblioteca (
    BibliotecaID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador �nico da biblioteca
    NomeBiblioteca NVARCHAR(100) NOT NULL,       -- Nome da biblioteca
    EnderecoBiblioteca NVARCHAR(200),            -- Endere�o da biblioteca
    CGC CHAR(14) NOT NULL UNIQUE                 -- CGC da biblioteca (�nico)
);
GO

-- Tabela TituloNotebook
CREATE TABLE TituloNotebook (
    TituloNotebookID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador �nico do t�tulo de notebook
    Modelo NVARCHAR(100),                             -- Modelo do notebook
    NumeroPC NVARCHAR(50),                           -- N�mero do PC
    TituloID INT,                                    -- Relacionamento com a tabela Titulo
    FOREIGN KEY (TituloID) REFERENCES Titulo(TituloID)  -- Chave estrangeira
);
GO

-- Tabela TituloPeriodico
CREATE TABLE TituloPeriodico (
    TituloPeriodicoID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador �nico do t�tulo peri�dico
    Volume INT,                                       -- Volume do peri�dico
    Numero INT,                                       -- N�mero do peri�dico
    Data DATE,                                        -- Data de publica��o
    TituloID INT,                                     -- Relacionamento com a tabela Titulo
    FOREIGN KEY (TituloID) REFERENCES Titulo(TituloID)  -- Chave estrangeira
);
GO

-- Tabela Periodicos
CREATE TABLE Periodicos (
    PeriodicoID INT PRIMARY KEY IDENTITY(1,1),     -- Identificador �nico do peri�dico
    Nome NVARCHAR(100),                             -- Nome do peri�dico
    CPF CHAR(11) NOT NULL,                          -- CPF do cliente (associado a ClienteBiblioteca)
    Prioridade INT,                                 -- Prioridade do peri�dico
    FOREIGN KEY (CPF) REFERENCES ClienteBiblioteca(CPF)  -- Chave estrangeira
);
GO

-- Tabela TituloLivro
CREATE TABLE TituloLivro (
    TituloLivroID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador �nico do t�tulo de livro
    Autor NVARCHAR(100),                          -- Autor do livro
    Titulo NVARCHAR(200),                         -- T�tulo do livro
    ISBN CHAR(13),                                -- ISBN do livro
    LocalEdicao NVARCHAR(100),                    -- Local de edi��o
    Editora NVARCHAR(100),                        -- Editora do livro
    AnoEdicao INT,                                -- Ano de edi��o
    NumeroPaginas INT,                            -- N�mero de p�ginas
    TituloID INT,                                 -- Relacionamento com a tabela Titulo
    FOREIGN KEY (TituloID) REFERENCES Titulo(TituloID)  -- Chave estrangeira
);
GO


--Inser��o de Dados

-- Inserir dados na tabela ClienteBiblioteca
INSERT INTO ClienteBiblioteca (Nome, CPF, Endereco, Telefone, EnderecoEletronico, LimiteReservas, LimiteEmprestimos)
VALUES 
    ('Jo�o Silva', '12345678901', 'Rua A, 123, Centro', '1234-5678', 'joao@email.com', 5, 3),
    ('Maria Oliveira', '23456789012', 'Rua B, 456, Bairro X', '2345-6789', 'maria@email.com', 3, 2),
    ('Carlos Pereira', '34567890123', 'Rua C, 789, Zona Leste', '3456-7890', 'carlos@email.com', 4, 4),
    ('Ana Costa', '45678901234', 'Rua D, 1011, Zona Oeste', '4567-8901', 'ana@email.com', 2, 1);
GO

-- Inserir dados na tabela Emprestimo
INSERT INTO Emprestimo (ClienteID, DataEmprestimo, Estado)
VALUES
    (1, '2024-12-01', 'Aberto'),
    (2, '2024-11-15', 'Fechado'),
    (3, '2024-10-10', 'Aberto'),
    (4, '2024-09-30', 'Fechado');
GO

-- Inserir dados na tabela Item
INSERT INTO Item (Estado, DataAquisicao)
VALUES
    ('Dispon�vel', '2023-06-01'),
    ('Emprestado', '2022-07-15'),
    ('Dispon�vel', '2021-03-20'),
    ('Emprestado', '2024-01-10');
GO

-- Inserir dados na tabela Reserva
INSERT INTO Reserva (ClienteID, ItemID, DataReserva)
VALUES
    (1, 1, '2024-12-05'),
    (2, 3, '2024-12-08'),
    (3, 4, '2024-12-07'),
    (4, 2, '2024-12-06');
GO

-- Inserir dados na tabela Titulo
INSERT INTO Titulo (Classificacao, Cutter, TempoEmprestimo, PalavrasChave)
VALUES
    ('Fic��o', 'F123', 14, 'aventura, mist�rio'),
    ('Romance', 'R456', 21, 'amor, drama'),
    ('Ci�ncia', 'C789', 30, 'f�sica, qu�mica, biologia'),
    ('Tecnologia', 'T012', 10, 'programa��o, IA, computa��o');
GO

-- Inserir dados na tabela Biblioteca
INSERT INTO Biblioteca (NomeBiblioteca, EnderecoBiblioteca, CGC)
VALUES
    ('Biblioteca Central', 'Av. Brasil, 1000', '12345678000199'),
    ('Biblioteca Zona Norte', 'Rua Norte, 200', '23456789000111');
GO

-- Inserir dados na tabela TituloNotebook
INSERT INTO TituloNotebook (Modelo, NumeroPC, TituloID)
VALUES
    ('Dell Inspiron', 'PC12345', 1),
    ('HP Pavilion', 'PC67890', 2);
GO

-- Inserir dados na tabela TituloPeriodico
INSERT INTO TituloPeriodico (Volume, Numero, Data, TituloID)
VALUES
    (10, 2, '2024-05-01', 3),
    (15, 5, '2024-06-10', 4);
GO

-- Inserir dados na tabela Periodicos
INSERT INTO Periodicos (Nome, CPF, Prioridade)
VALUES
    ('Revista Ci�ncia', '34567890123', 1),
    ('Revista Tecnologia', '45678901234', 2);
GO

-- Inserir dados na tabela TituloLivro
INSERT INTO TituloLivro (Autor, Titulo, ISBN, LocalEdicao, Editora, AnoEdicao, NumeroPaginas, TituloID)
VALUES
    ('J.K. Rowling', 'Harry Potter e a Pedra Filosofal', '9780747532743', 'Londres', 'Bloomsbury', 1997, 223, 1),
    ('George Orwell', '1984', '9780451524935', 'Londres', 'Harcourt', 1949, 328, 2);
GO


-- Consultas para Visualizar os Dados


-- Consultar todos os clientes
SELECT * 
FROM ClienteBiblioteca;


-- Consultar todos os empr�stimos
SELECT * 
FROM Emprestimo;


-- Consultar todos os itens
SELECT *
FROM Item;


-- Consultar todas as reservas
SELECT * 
FROM Reserva;


-- Consultar todos os t�tulos
SELECT *
FROM Titulo;


-- Consultar todas as bibliotecas
SELECT * 
FROM Biblioteca;


-- Consultar todos os t�tulos de notebooks
SELECT * 
FROM TituloNotebook;


-- Consultar todos os t�tulos peri�dicos
SELECT *
FROM TituloPeriodico;


-- Consultar todos os peri�dicos
SELECT * 
FROM Periodicos;


-- Consultar todos os t�tulos de livros
SELECT * 
FROM TituloLivro;

