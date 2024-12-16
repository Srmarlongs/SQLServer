-- Cria��o do banco de dados
CREATE DATABASE oficina_reboque;
GO

-- Selecionando o banco de dados
USE oficina_reboque;
GO

-- Tabela para Reboquista
CREATE TABLE Reboquista (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Reboquista
    nome VARCHAR(255),                    -- Nome do Reboquista
    cpf VARCHAR(20) UNIQUE,               -- CPF do Reboquista (�nico)
    telefone VARCHAR(20),                 -- Telefone do Reboquista
    veiculo VARCHAR(255),                 -- Ve�culo do Reboquista
    data_reboque DATE                     -- Data do Reboque
);
GO

-- Tabela para Oficina
CREATE TABLE Oficina (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID da Oficina
    nome_oficina VARCHAR(255),            -- Nome da Oficina
    endereco VARCHAR(255),                -- Endere�o da Oficina
    cnpj VARCHAR(20) UNIQUE,              -- CNPJ da Oficina (�nico)
    telefone VARCHAR(20)                  -- Telefone da Oficina
);
GO

-- Tabela para Cliente (relacionado � Oficina)
CREATE TABLE Cliente (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Cliente
    nome VARCHAR(255),                    -- Nome do Cliente
    cpf VARCHAR(20) UNIQUE,               -- CPF do Cliente (�nico)
    endereco VARCHAR(255),                -- Endere�o do Cliente
    telefone VARCHAR(20),                 -- Telefone do Cliente
    endereco_eletronico VARCHAR(255)      -- Endere�o eletr�nico do Cliente
);
GO

-- Tabela para Pe�as
CREATE TABLE Peca (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID da Pe�a
    nome_peca VARCHAR(255),               -- Nome da Pe�a
    codigo_peca VARCHAR(50) UNIQUE,       -- C�digo �nico da Pe�a
    preco DECIMAL(10,2),                  -- Pre�o da Pe�a
    fornecedor VARCHAR(255),              -- Fornecedor da Pe�a
    quantidade_estoque INT                -- Quantidade em estoque
);
GO

-- Tabela para Mec�nico
CREATE TABLE Mecanico (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Mec�nico
    nome VARCHAR(255),                    -- Nome do Mec�nico
    cpf VARCHAR(20) UNIQUE,               -- CPF do Mec�nico (�nico)
    endereco VARCHAR(255),                -- Endere�o do Mec�nico
    telefone VARCHAR(20)                  -- Telefone do Mec�nico
);
GO

-- Tabela para Servi�o
CREATE TABLE Servico (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Servi�o
    tipo_servico VARCHAR(255),            -- Tipo de Servi�o (Ex: troca de �leo)
    descricao TEXT,                       -- Descri��o do Servi�o
    status VARCHAR(50),                   -- Status do Servi�o (Ex: Em andamento, Conclu�do)
    data_inicio DATE,                     -- Data de in�cio do servi�o
    data_conclusao DATE,                  -- Data de conclus�o do servi�o
    id_mecanico INT,                      -- ID do Mec�nico respons�vel
    FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id)  -- Relacionamento com Mec�nico
);
GO

-- Tabela para Registro de Reboques
CREATE TABLE Reboque (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Reboque
    id_reboquista INT,                    -- ID do Reboquista respons�vel
    id_oficina INT,                       -- ID da Oficina destino
    id_cliente INT,                       -- ID do Cliente que solicitou
    id_veiculo INT,                       -- ID do Ve�culo que foi rebocado
    data_reboque DATE,                    -- Data do Reboque
    FOREIGN KEY (id_reboquista) REFERENCES Reboquista(id),  -- Relacionamento com Reboquista
    FOREIGN KEY (id_oficina) REFERENCES Oficina(id),      -- Relacionamento com Oficina
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)        -- Relacionamento com Cliente
);
GO

-- Tabela para Relacionamento de Servi�os e Pe�as
CREATE TABLE ServicoPeca (
    id_servico INT,                       -- ID do Servi�o
    id_peca INT,                          -- ID da Pe�a utilizada no servi�o
    PRIMARY KEY (id_servico, id_peca),    -- Chave prim�ria composta
    FOREIGN KEY (id_servico) REFERENCES Servico(id),    -- Relacionamento com Servi�o
    FOREIGN KEY (id_peca) REFERENCES Peca(id)           -- Relacionamento com Pe�a
);
GO

-- Inser��o de Dados Aleat�rios

-- Inserir dados na tabela Reboquista
INSERT INTO Reboquista (nome, cpf, telefone, veiculo, data_reboque)
VALUES
    ('Carlos Oliveira', '12345678901', '1112345678', 'Reboque X - Ford Ranger', '2024-12-10'),
    ('Ana Pereira', '10987654321', '1198765432', 'Reboque Y - Fiat Toro', '2024-12-05');
GO

-- Inserir dados na tabela Oficina
INSERT INTO Oficina (nome_oficina, endereco, cnpj, telefone)
VALUES
    ('Oficina do Jo�o', 'Rua das Flores, 123', '12345678000195', '1122334455'),
    ('Oficina 24h', 'Av. Brasil, 456', '98765432000100', '2233445566');
GO

-- Inserir dados na tabela Cliente
INSERT INTO Cliente (nome, cpf, endereco, telefone, endereco_eletronico)
VALUES
    ('Lucia Santos', '11223344556', 'Rua A, 101', '1122334455', 'lucia@email.com'),
    ('Pedro Martins', '55443322112', 'Rua B, 202', '5566778899', 'pedro@email.com');
GO

-- Inserir dados na tabela Pe�a
INSERT INTO Peca (nome_peca, codigo_peca, preco, fornecedor, quantidade_estoque)
VALUES
    ('Pneu', 'PNEU001', 200.00, 'Fornecedor A', 15),
    ('Filtro de �leo', 'FILT001', 50.00, 'Fornecedor B', 30),
    ('Pastilha de freio', 'PST001', 150.00, 'Fornecedor C', 20);
GO

-- Inserir dados na tabela Mec�nico
INSERT INTO Mecanico (nome, cpf, endereco, telefone)
VALUES
    ('Jo�o Souza', '56789012345', 'Rua C, 303', '3344556677'),
    ('Maria Alves', '78945612300', 'Av. D, 404', '4455667788');
GO

-- Inserir dados na tabela Servi�o
INSERT INTO Servico (tipo_servico, descricao, status, data_inicio, data_conclusao, id_mecanico)
VALUES
    ('Troca de �leo', 'Troca de �leo do motor', 'Conclu�do', '2024-12-01', '2024-12-02', 1),
    ('Troca de pastilhas de freio', 'Substitui��o das pastilhas de freio dianteiras', 'Em andamento', '2024-12-03', 2);
GO

-- Inserir dados na tabela Reboque
INSERT INTO Reboque (id_reboquista, id_oficina, id_cliente, id_veiculo, data_reboque)
VALUES
    (1, 1, 1, 1, '2024-12-10'),
    (2, 2, 2, 2, '2024-12-05');
GO

-- Inserir dados na tabela ServicoPeca
INSERT INTO ServicoPeca (id_servico, id_peca)
VALUES
    (1, 1),  -- Troca de �leo e Pneu
    (2, 3);  -- Troca de pastilhas e Pastilha de freio
GO

-- Consultas para Visualiza��o de Dados

-- Consultar todos os Reboquistas
SELECT * 
FROM Reboquista;

-- Consultar todos os Clientes
SELECT * 
FROM Cliente;

-- Consultar todos os Servi�os
SELECT * 
FROM Servico;

-- Consultar todas as Pe�as em estoque
SELECT * 
FROM Peca;

-- Consultar as pe�as usadas em um servi�o espec�fico
SELECT 
    s.tipo_servico, 
    p.nome_peca
FROM Servico s
JOIN ServicoPeca sp ON s.id = sp.id_servico
JOIN Peca p ON sp.id_peca = p.id
WHERE s.id = 1;

-- Consultar os reboques realizados por um reboquista
SELECT 
    r.id AS ReboqueID, 
    o.nome_oficina, 
    c.nome AS ClienteNome, 
    r.data_reboque
FROM Reboque r
JOIN Oficina o ON r.id_oficina = o.id
JOIN Cliente c ON r.id_cliente = c.id
WHERE r.id_reboquista = 1;
