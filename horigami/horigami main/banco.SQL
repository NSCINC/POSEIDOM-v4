-- Criação da tabela Users
CREATE TABLE IF NOT EXISTS Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password_hash VARCHAR(64) NOT NULL,
    UNIQUE (username)
);

-- Inserção de dados de exemplo
INSERT INTO Users (username, password_hash) VALUES ('alice', '63a9f0ea7bb98050796b649e85481845');
INSERT INTO Users (username, password_hash) VALUES ('bob', '2ba6f0ea7bb98050e4f998ba5b4f874a');
INSERT INTO Users (username, password_hash) VALUES ('charlie', '46de5f0ea7bb98050796b649e85481845');

-- Consulta de autenticação de usuário
SELECT * FROM Users WHERE username = 'alice' AND password_hash = '63a9f0ea7bb98050796b649e85481845';
