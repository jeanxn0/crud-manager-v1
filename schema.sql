-- Execute no MySQL Workbench. As tabelas existentes são preservadas.
CREATE DATABASE IF NOT EXISTS crud_manager CHARACTER SET utf8mb4;
USE crud_manager;

-- Ordem das colunas conforme os INSERTs do CRUD Manager.
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    sexo VARCHAR(30),
    email VARCHAR(254) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    post_date DATE NOT NULL,
    user_id INT NOT NULL,
    CONSTRAINT fk_posts_user FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS companies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    role VARCHAR(150) NOT NULL,
    start DATE NOT NULL,
    `end` DATE,
    user_id INT NOT NULL,
    CONSTRAINT fk_companies_user FOREIGN KEY (user_id) REFERENCES users(id)
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
