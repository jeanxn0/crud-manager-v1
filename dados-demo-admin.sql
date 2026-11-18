-- Dados FICTICIOS opcionais para demonstrar telas administrativas.
-- Execute somente se quiser preencher Usuarios, Empresas e Posts para avaliacao.
-- Reexecutar nao deve duplicar os registros.
USE crud_manager;
START TRANSACTION;

INSERT INTO users (nome, sexo, email)
SELECT 'Ana Demo', 'F', 'ana.demo@example.invalid'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'ana.demo@example.invalid');
INSERT INTO users (nome, sexo, email)
SELECT 'Bruno Demo', 'M', 'bruno.demo@example.invalid'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'bruno.demo@example.invalid');
INSERT INTO users (nome, sexo, email)
SELECT 'Camila Demo', 'F', 'camila.demo@example.invalid'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'camila.demo@example.invalid');
INSERT INTO users (nome, sexo, email)
SELECT 'Diego Demo', 'M', 'diego.demo@example.invalid'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'diego.demo@example.invalid');

INSERT INTO companies (name, role, start, `end`, user_id)
SELECT 'Game Lab Studio', 'Designer de jogos', '2025-02-01', NULL, id
FROM users WHERE email = 'ana.demo@example.invalid'
  AND NOT EXISTS (SELECT 1 FROM companies WHERE name = 'Game Lab Studio' AND user_id = users.id);
INSERT INTO companies (name, role, start, `end`, user_id)
SELECT 'Pixel Forge', 'Desenvolvedor', '2024-01-10', NULL, id
FROM users WHERE email = 'bruno.demo@example.invalid'
  AND NOT EXISTS (SELECT 1 FROM companies WHERE name = 'Pixel Forge' AND user_id = users.id);
INSERT INTO companies (name, role, start, `end`, user_id)
SELECT 'Nexus Digital', 'Analista de dados', '2023-05-15', '2025-03-18', id
FROM users WHERE email = 'camila.demo@example.invalid'
  AND NOT EXISTS (SELECT 1 FROM companies WHERE name = 'Nexus Digital' AND user_id = users.id);
INSERT INTO companies (name, role, start, `end`, user_id)
SELECT 'Next Level Tech', 'Suporte técnico', '2026-01-20', NULL, id
FROM users WHERE email = 'diego.demo@example.invalid'
  AND NOT EXISTS (SELECT 1 FROM companies WHERE name = 'Next Level Tech' AND user_id = users.id);

INSERT INTO posts (content, post_date, user_id)
SELECT 'Novos jogos adicionados ao catalogo da loja demonstrativa!', CURDATE(), id
FROM users WHERE email = 'ana.demo@example.invalid'
  AND NOT EXISTS (SELECT 1 FROM posts WHERE content='Novos jogos adicionados ao catalogo da loja demonstrativa!');
INSERT INTO posts (content, post_date, user_id)
SELECT 'Cadastro de usuarios e gerenciamento de empresas disponiveis.', CURDATE(), id
FROM users WHERE email = 'bruno.demo@example.invalid'
  AND NOT EXISTS (SELECT 1 FROM posts WHERE content='Cadastro de usuarios e gerenciamento de empresas disponiveis.');
INSERT INTO posts (content, post_date, user_id)
SELECT 'Pedidos do catalogo podem ser consultados na pagina Vendas.', CURDATE(), id
FROM users WHERE email = 'camila.demo@example.invalid'
  AND NOT EXISTS (SELECT 1 FROM posts WHERE content='Pedidos do catalogo podem ser consultados na pagina Vendas.');
INSERT INTO posts (content, post_date, user_id)
SELECT 'Loja de demonstracao: sem pagamentos reais.', CURDATE(), id
FROM users WHERE email = 'diego.demo@example.invalid'
  AND NOT EXISTS (SELECT 1 FROM posts WHERE content='Loja de demonstracao: sem pagamentos reais.');
COMMIT;
