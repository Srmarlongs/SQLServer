-- Criação do banco de dados
CREATE DATABASE oficina_reboque;
GO

-- Selecionando o banco de dados
USE oficina_reboque;
GO

-- Tabela para Reboquista
CREATE TABLE Reboquista (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Reboquista
    nome VARCHAR(255),                    -- Nome do Reboquista
    cpf VARCHAR(20) UNIQUE,               -- CPF do Reboquista (único)
    telefone VARCHAR(20),                 -- Telefone do Reboquista
    veiculo VARCHAR(255),                 -- Veículo do Reboquista
    data_reboque DATE                     -- Data do Reboque
);
GO

-- Tabela para Oficina
CREATE TABLE Oficina (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID da Oficina
    nome_oficina VARCHAR(255),            -- Nome da Oficina
    endereco VARCHAR(255),                -- Endereço da Oficina
    cnpj VARCHAR(20) UNIQUE,              -- CNPJ da Oficina (único)
    telefone VARCHAR(20)                  -- Telefone da Oficina
);
GO

-- Tabela para Cliente (relacionado à Oficina)
CREATE TABLE Cliente (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Cliente
    nome VARCHAR(255),                    -- Nome do Cliente
    cpf VARCHAR(20) UNIQUE,               -- CPF do Cliente (único)
    endereco VARCHAR(255),                -- Endereço do Cliente
    telefone VARCHAR(20),                 -- Telefone do Cliente
    endereco_eletronico VARCHAR(255)      -- Endereço eletrônico do Cliente
);
GO

-- Tabela para Peças
CREATE TABLE Peca (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID da Peça
    nome_peca VARCHAR(255),               -- Nome da Peça
    codigo_peca VARCHAR(50) UNIQUE,       -- Código único da Peça
    preco DECIMAL(10,2),                  -- Preço da Peça
    fornecedor VARCHAR(255),              -- Fornecedor da Peça
    quantidade_estoque INT                -- Quantidade em estoque
);
GO

-- Tabela para Mecânico
CREATE TABLE Mecanico (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Mecânico
    nome VARCHAR(255),                    -- Nome do Mecânico
    cpf VARCHAR(20) UNIQUE,               -- CPF do Mecânico (único)
    endereco VARCHAR(255),                -- Endereço do Mecânico
    telefone VARCHAR(20)                  -- Telefone do Mecânico
);
GO

-- Tabela para Serviço
CREATE TABLE Servico (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Serviço
    tipo_servico VARCHAR(255),            -- Tipo de Serviço (Ex: troca de óleo)
    descricao TEXT,                       -- Descrição do Serviço
    status VARCHAR(50),                   -- Status do Serviço (Ex: Em andamento, Concluído)
    data_inicio DATE,                     -- Data de início do serviço
    data_conclusao DATE,                  -- Data de conclusão do serviço
    id_mecanico INT,                      -- ID do Mecânico responsável
    FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id)  -- Relacionamento com Mecânico
);
GO

-- Tabela para Registro de Reboques
CREATE TABLE Reboque (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Reboque
    id_reboquista INT,                    -- ID do Reboquista responsável
    id_oficina INT,                       -- ID da Oficina destino
    id_cliente INT,                       -- ID do Cliente que solicitou
    id_veiculo INT,                       -- ID do Veículo que foi rebocado
    data_reboque DATE,                    -- Data do Reboque
    FOREIGN KEY (id_reboquista) REFERENCES Reboquista(id),  -- Relacionamento com Reboquista
    FOREIGN KEY (id_oficina) REFERENCES Oficina(id),      -- Relacionamento com Oficina
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)        -- Relacionamento com Cliente
);
GO

-- Tabela para Relacionamento de Serviços e Peças
CREATE TABLE ServicoPeca (
    id_servico INT,                       -- ID do Serviço
    id_peca INT,                          -- ID da Peça utilizada no serviço
    PRIMARY KEY (id_servico, id_peca),    -- Chave primária composta
    FOREIGN KEY (id_servico) REFERENCES Servico(id),    -- Relacionamento com Serviço
    FOREIGN KEY (id_peca) REFERENCES Peca(id)           -- Relacionamento com Peça
);
GO

-- Inserção de Dados Aleatórios

-- Inserir dados na tabela Reboquista
INSERT INTO Reboquista (nome, cpf, telefone, veiculo, data_reboque)
VALUES
    ('Carlos Oliveira', '12345678901', '1112345678', 'Reboque X - Ford Ranger', '2024-12-10'),
    ('Ana Pereira', '10987654321', '1198765432', 'Reboque Y - Fiat Toro', '2024-12-05');
GO

-- Inserir dados na tabela Oficina
INSERT INTO Oficina (nome_oficina, endereco, cnpj, telefone)
VALUES
    ('Oficina do João', 'Rua das Flores, 123', '12345678000195', '1122334455'),
    ('Oficina 24h', 'Av. Brasil, 456', '98765432000100', '2233445566');
GO

-- Inserir dados na tabela Cliente
INSERT INTO Cliente (nome, cpf, endereco, telefone, endereco_eletronico)
VALUES
    ('Lucia Santos', '11223344556', 'Rua A, 101', '1122334455', 'lucia@email.com'),
    ('Pedro Martins', '55443322112', 'Rua B, 202', '5566778899', 'pedro@email.com');
GO

-- Inserir dados na tabela Peça
INSERT INTO Peca (nome_peca, codigo_peca, preco, fornecedor, quantidade_estoque)
VALUES
    ('Pneu', 'PNEU001', 200.00, 'Fornecedor A', 15),
    ('Filtro de óleo', 'FILT001', 50.00, 'Fornecedor B', 30),
    ('Pastilha de freio', 'PST001', 150.00, 'Fornecedor C', 20);
GO

-- Inserir dados na tabela Mecânico
INSERT INTO Mecanico (nome, cpf, endereco, telefone)
VALUES
    ('João Souza', '56789012345', 'Rua C, 303', '3344556677'),
    ('Maria Alves', '78945612300', 'Av. D, 404', '4455667788');
GO

-- Inserir dados na tabela Serviço
INSERT INTO Servico (tipo_servico, descricao, status, data_inicio, data_conclusao, id_mecanico)
VALUES
    ('Troca de óleo', 'Troca de óleo do motor', 'Concluído', '2024-12-01', '2024-12-02', 1),
    ('Troca de pastilhas de freio', 'Substituição das pastilhas de freio dianteiras', 'Em andamento', '2024-12-03', 2);
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
    (1, 1),  -- Troca de óleo e Pneu
    (2, 3);  -- Troca de pastilhas e Pastilha de freio
GO

-- Consultas para Visualização de Dados

-- Consultar todos os Reboquistas
SELECT * 
FROM Reboquista;

-- Consultar todos os Clientes
SELECT * 
FROM Cliente;

-- Consultar todos os Serviços
SELECT * 
FROM Servico;

-- Consultar todas as Peças em estoque
SELECT * 
FROM Peca;

-- Consultar as peças usadas em um serviço específico
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
