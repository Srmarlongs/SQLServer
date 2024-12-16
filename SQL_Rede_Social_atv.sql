-- Selecionando o banco de dados
create database rede_social;

USE rede_social;
GO

-- Tabela para notificações
CREATE TABLE Notificacao (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID da Notificação
    tipo_notificacao VARCHAR(255),       -- Tipo da Notificação
    mensagem TEXT,                       -- Mensagem da Notificação
    data_notificacao DATE,               -- Data de criação da Notificação
    marcada_como_lida BIT DEFAULT 0     -- Flag para marcar como lida
);
GO

-- Tabela para usuários
CREATE TABLE Usuario (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Usuário
    nome VARCHAR(255),                    -- Nome do Usuário
    email VARCHAR(255) UNIQUE,            -- Email do Usuário (único)
    data_nascimento DATE,                 -- Data de nascimento
    website VARCHAR(255),                 -- Website ou link do Usuário
    genero VARCHAR(50),                   -- Gênero do Usuário
    telefone VARCHAR(20),                 -- Número de telefone
    foto_perfil VARCHAR(255)              -- Caminho da foto de perfil
);
GO

-- Tabela para seguidores e seguindo (relacionamento de muitos para muitos)
CREATE TABLE Seguindo (
    id_usuario INT,                       -- ID do Usuário
    id_seguindo INT,                       -- ID do usuário que está sendo seguido
    PRIMARY KEY (id_usuario, id_seguindo), -- Chave primária composta
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id), -- Relacionamento com Usuário
    FOREIGN KEY (id_seguindo) REFERENCES Usuario(id)  -- Relacionamento com Usuário
);
GO

-- Tabela para postagens
CREATE TABLE Postagem (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID da Postagem
    id_usuario INT,                      -- ID do Usuário que fez a postagem
    conteudo TEXT,                        -- Conteúdo da postagem
    data_postagem DATE,                   -- Data da postagem
    uri_foto VARCHAR(255),                -- Caminho de uma foto associada à postagem
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) -- Relacionamento com Usuário
);
GO

-- Tabela para álbuns
CREATE TABLE Album (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID do Álbum
    id_usuario INT,                      -- ID do Usuário que criou o álbum
    titulo VARCHAR(255),                  -- Título do Álbum
    data_criacao DATE,                    -- Data de criação do Álbum
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) -- Relacionamento com Usuário
);
GO

-- Tabela para fotos (relacionando com álbuns e postagens)
CREATE TABLE Foto (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- ID da Foto
    id_album INT,                         -- ID do Álbum ao qual a foto pertence
    id_postagem INT,                      -- ID da Postagem relacionada à foto
    uri_foto VARCHAR(255),                -- Caminho da foto
    data_upload DATE,                     -- Data do upload
    descricao TEXT,                       -- Descrição da foto
    FOREIGN KEY (id_album) REFERENCES Album(id),       -- Relacionamento com Álbum
    FOREIGN KEY (id_postagem) REFERENCES Postagem(id)  -- Relacionamento com Postagem
);
GO

-- Tabela de timeline (relacionamento de postagens)
CREATE TABLE Timeline (
    id_usuario INT,                       -- ID do Usuário
    id_postagem INT,                      -- ID da Postagem na timeline
    PRIMARY KEY (id_usuario, id_postagem),-- Chave primária composta
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id), -- Relacionamento com Usuário
    FOREIGN KEY (id_postagem) REFERENCES Postagem(id) -- Relacionamento com Postagem
);
GO

-- Tabela para relacionamento entre usuários e fotos compartilhadas
CREATE TABLE FotoCompartilhada (
    id_usuario INT,                       -- ID do Usuário que compartilhou a foto
    id_foto INT,                           -- ID da Foto compartilhada
    PRIMARY KEY (id_usuario, id_foto),     -- Chave primária composta
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id), -- Relacionamento com Usuário
    FOREIGN KEY (id_foto) REFERENCES Foto(id)        -- Relacionamento com Foto
);
GO

-- Inserção de Dados Aleatórios

-- Inserir dados na tabela Usuario
INSERT INTO Usuario (nome, email, data_nascimento, website, genero, telefone, foto_perfil)
VALUES
    ('João Silva', 'joao.silva@email.com', '1990-06-15', 'www.joaosilva.com', 'Masculino', '123456789', 'foto_joao.jpg'),
    ('Maria Oliveira', 'maria.oliveira@email.com', '1992-03-22', 'www.mariaoliveira.com', 'Feminino', '987654321', 'foto_maria.jpg'),
    ('Carlos Souza', 'carlos.souza@email.com', '1985-11-30', 'www.carlossouza.com', 'Masculino', '456789123', 'foto_carlos.jpg');
GO

-- Inserir dados na tabela Postagem
INSERT INTO Postagem (id_usuario, conteudo, data_postagem, uri_foto)
VALUES
    (1, 'Minha primeira postagem!', '2024-12-01', 'foto_postagem_1.jpg'),
    (2, 'Estou amando o dia de hoje!', '2024-12-05', 'foto_postagem_2.jpg'),
    (3, 'Nada melhor do que um bom café!', '2024-12-10', 'foto_postagem_3.jpg');
GO

-- Inserir dados na tabela Album
INSERT INTO Album (id_usuario, titulo, data_criacao)
VALUES
    (1, 'Viagem a Paris', '2024-11-15'),
    (2, 'Meu Casamento', '2023-09-20'),
    (3, 'Férias em Gramado', '2024-08-10');
GO

-- Inserir dados na tabela Foto
INSERT INTO Foto (id_album, id_postagem, uri_foto, data_upload, descricao)
VALUES
    (1, 1, 'foto_album_1.jpg', '2024-11-16', 'Vista da Torre Eiffel'),
    (2, 2, 'foto_album_2.jpg', '2023-09-21', 'Casamento com meu amor'),
    (3, 3, 'foto_album_3.jpg', '2024-08-11', 'Paisagem de Gramado');
GO

-- Inserir dados na tabela Seguindo
INSERT INTO Seguindo (id_usuario, id_seguindo)
VALUES
    (1, 2),  -- João segue Maria
    (2, 3),  -- Maria segue Carlos
    (3, 1);  -- Carlos segue João
GO

-- Inserir dados na tabela Timeline
INSERT INTO Timeline (id_usuario, id_postagem)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);
GO

-- Consultas para Visualização de Dados

-- Consultar todos os Usuários
SELECT * 
FROM Usuario;

-- Consultar todas as Postagens
SELECT * 
FROM Postagem;

-- Consultar todos os Álbuns
SELECT * 
FROM Album;

-- Consultar as Fotos de um Álbum específico
SELECT * 
FROM Foto
WHERE id_album = 1;

-- Consultar quem segue quem (seguindo relacionamento)
SELECT 
    u1.nome AS Seguidor, 
    u2.nome AS Seguindo
FROM Seguindo s
JOIN Usuario u1 ON s.id_usuario = u1.id
JOIN Usuario u2 ON s.id_seguindo = u2.id;

-- Consultar a timeline de um usuário específico
SELECT 
    p.conteudo, 
    p.data_postagem
FROM Timeline t
JOIN Postagem p ON t.id_postagem = p.id
WHERE t.id_usuario = 1;
