CREATE DATABASE IF NOT EXISTS crud_manager CHARACTER SET utf8mb4;
USE crud_manager;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    sexo VARCHAR(30),
    email VARCHAR(254) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS contas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NULL,
    sexo VARCHAR(30) NULL,
    email VARCHAR(254) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    post_date DATE NOT NULL,
    user_id INT NULL,
    conta_id INT NULL,
    CONSTRAINT fk_posts_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_posts_conta FOREIGN KEY (conta_id) REFERENCES contas(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS companies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    role VARCHAR(150) NOT NULL,
    start DATE NOT NULL,
    `end` DATE,
    user_id INT NULL,
    conta_id INT NULL,
    CONSTRAINT fk_companies_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_companies_conta FOREIGN KEY (conta_id) REFERENCES contas(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS jogos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT NOT NULL,
    data_lancamento DATE NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    usuario_id INT NOT NULL,
    CONSTRAINT ck_jogos_preco CHECK (preco >= 0),
    CONSTRAINT fk_jogos_usuario FOREIGN KEY (usuario_id) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    jogo_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,
    data_venda DATETIME NOT NULL,
    status_pagamento ENUM('PENDENTE', 'PAGO', 'CANCELADO') NOT NULL DEFAULT 'PENDENTE',
    CONSTRAINT ck_vendas_quantidade CHECK (quantidade > 0),
    CONSTRAINT ck_vendas_valor CHECK (valor_total >= 0),
    CONSTRAINT fk_vendas_jogo FOREIGN KEY (jogo_id) REFERENCES jogos(id)
) ENGINE=InnoDB;

SHOW TABLES;



CREATE TABLE IF NOT EXISTS capas_jogos (
    jogo_id INT PRIMARY KEY,
    steam_app_id INT NOT NULL UNIQUE,
    FOREIGN KEY (jogo_id) REFERENCES jogos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS plataformas_jogos (
    jogo_id INT NOT NULL,
    plataforma VARCHAR(24) NOT NULL,
    PRIMARY KEY (jogo_id, plataforma),
    FOREIGN KEY (jogo_id) REFERENCES jogos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS administradores (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    trocar_senha BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
