-- Criação do banco de dados
CREATE DATABASE Biblioteca_atv;
GO

-- Seleção do banco de dados
USE Biblioteca_atv;
GO

-- Tabela ClienteBiblioteca
CREATE TABLE ClienteBiblioteca (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),    -- Identificador único do cliente
    Nome NVARCHAR(100) NOT NULL,                 -- Nome do cliente
    CPF CHAR(11) NOT NULL UNIQUE,                -- CPF do cliente (único)
    Endereco NVARCHAR(200),                      -- Endereço do cliente
    Telefone NVARCHAR(15),                       -- Telefone do cliente
    EnderecoEletronico NVARCHAR(100),            -- E-mail do cliente
    LimiteReservas INT DEFAULT 0,                -- Limite de reservas permitidas
    LimiteEmprestimos INT DEFAULT 0              -- Limite de empréstimos permitidos
);
GO

-- Tabela Emprestimo
CREATE TABLE Emprestimo (
    EmprestimoID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador único do empréstimo
    ClienteID INT,                               -- Relacionamento com a tabela ClienteBiblioteca
    DataEmprestimo DATE NOT NULL,                -- Data do empréstimo
    Estado NVARCHAR(50),                         -- Estado do empréstimo (ex: Aberto, Fechado)
    FOREIGN KEY (ClienteID) REFERENCES ClienteBiblioteca(ClienteID)  -- Chave estrangeira
);
GO

-- Tabela Item
CREATE TABLE Item (
    ItemID INT PRIMARY KEY IDENTITY(1,1),       -- Identificador único do item
    Estado NVARCHAR(50),                         -- Estado do item (ex: Disponível, Emprestado)
    DataAquisicao DATE                           -- Data de aquisição do item
);
GO

-- Tabela Reserva
CREATE TABLE Reserva (
    ReservaID INT PRIMARY KEY IDENTITY(1,1),    -- Identificador único da reserva
    ClienteID INT,                               -- Relacionamento com a tabela ClienteBiblioteca
    ItemID INT,                                  -- Relacionamento com a tabela Item
    DataReserva DATE NOT NULL,                   -- Data da reserva
    FOREIGN KEY (ClienteID) REFERENCES ClienteBiblioteca(ClienteID),  -- Chave estrangeira
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)  -- Chave estrangeira
);
GO

-- Tabela Titulo
CREATE TABLE Titulo (
    TituloID INT PRIMARY KEY IDENTITY(1,1),     -- Identificador único do título
    Classificacao NVARCHAR(50),                  -- Classificação do título
    Cutter NVARCHAR(50),                         -- Cutter do título
    TempoEmprestimo INT,                         -- Tempo de empréstimo em dias
    PalavrasChave NVARCHAR(200)                  -- Palavras-chave associadas ao título
);
GO

-- Tabela Biblioteca
CREATE TABLE Biblioteca (
    BibliotecaID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador único da biblioteca
    NomeBiblioteca NVARCHAR(100) NOT NULL,       -- Nome da biblioteca
    EnderecoBiblioteca NVARCHAR(200),            -- Endereço da biblioteca
    CGC CHAR(14) NOT NULL UNIQUE                 -- CGC da biblioteca (único)
);
GO

-- Tabela TituloNotebook
CREATE TABLE TituloNotebook (
    TituloNotebookID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador único do título de notebook
    Modelo NVARCHAR(100),                             -- Modelo do notebook
    NumeroPC NVARCHAR(50),                           -- Número do PC
    TituloID INT,                                    -- Relacionamento com a tabela Titulo
    FOREIGN KEY (TituloID) REFERENCES Titulo(TituloID)  -- Chave estrangeira
);
GO

-- Tabela TituloPeriodico
CREATE TABLE TituloPeriodico (
    TituloPeriodicoID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador único do título periódico
    Volume INT,                                       -- Volume do periódico
    Numero INT,                                       -- Número do periódico
    Data DATE,                                        -- Data de publicação
    TituloID INT,                                     -- Relacionamento com a tabela Titulo
    FOREIGN KEY (TituloID) REFERENCES Titulo(TituloID)  -- Chave estrangeira
);
GO

-- Tabela Periodicos
CREATE TABLE Periodicos (
    PeriodicoID INT PRIMARY KEY IDENTITY(1,1),     -- Identificador único do periódico
    Nome NVARCHAR(100),                             -- Nome do periódico
    CPF CHAR(11) NOT NULL,                          -- CPF do cliente (associado a ClienteBiblioteca)
    Prioridade INT,                                 -- Prioridade do periódico
    FOREIGN KEY (CPF) REFERENCES ClienteBiblioteca(CPF)  -- Chave estrangeira
);
GO

-- Tabela TituloLivro
CREATE TABLE TituloLivro (
    TituloLivroID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador único do título de livro
    Autor NVARCHAR(100),                          -- Autor do livro
    Titulo NVARCHAR(200),                         -- Título do livro
    ISBN CHAR(13),                                -- ISBN do livro
    LocalEdicao NVARCHAR(100),                    -- Local de edição
    Editora NVARCHAR(100),                        -- Editora do livro
    AnoEdicao INT,                                -- Ano de edição
    NumeroPaginas INT,                            -- Número de páginas
    TituloID INT,                                 -- Relacionamento com a tabela Titulo
    FOREIGN KEY (TituloID) REFERENCES Titulo(TituloID)  -- Chave estrangeira
);
GO


--Inserção de Dados

-- Inserir dados na tabela ClienteBiblioteca
INSERT INTO ClienteBiblioteca (Nome, CPF, Endereco, Telefone, EnderecoEletronico, LimiteReservas, LimiteEmprestimos)
VALUES 
    ('João Silva', '12345678901', 'Rua A, 123, Centro', '1234-5678', 'joao@email.com', 5, 3),
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
    ('Disponível', '2023-06-01'),
    ('Emprestado', '2022-07-15'),
    ('Disponível', '2021-03-20'),
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
    ('Ficção', 'F123', 14, 'aventura, mistério'),
    ('Romance', 'R456', 21, 'amor, drama'),
    ('Ciência', 'C789', 30, 'física, química, biologia'),
    ('Tecnologia', 'T012', 10, 'programação, IA, computação');
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
    ('Revista Ciência', '34567890123', 1),
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


-- Consultar todos os empréstimos
SELECT * 
FROM Emprestimo;


-- Consultar todos os itens
SELECT *
FROM Item;


-- Consultar todas as reservas
SELECT * 
FROM Reserva;


-- Consultar todos os títulos
SELECT *
FROM Titulo;


-- Consultar todas as bibliotecas
SELECT * 
FROM Biblioteca;


-- Consultar todos os títulos de notebooks
SELECT * 
FROM TituloNotebook;


-- Consultar todos os títulos periódicos
SELECT *
FROM TituloPeriodico;


-- Consultar todos os periódicos
SELECT * 
FROM Periodicos;


-- Consultar todos os títulos de livros
SELECT * 
FROM TituloLivro;

