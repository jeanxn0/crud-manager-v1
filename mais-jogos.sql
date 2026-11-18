USE crud_manager;
START TRANSACTION;
INSERT INTO users (nome, sexo, email)
SELECT 'Catálogo da loja', NULL, 'catalogo@example.invalid'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email='catalogo@example.invalid');
SET @responsavel = (SELECT MIN(id) FROM users WHERE email='catalogo@example.invalid');

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Grand Theft Auto V', 'Ação e mundo aberto', '2015-04-14', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Grand Theft Auto V');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 271590 FROM jogos WHERE titulo='Grand Theft Auto V'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=271590)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Grand Theft Auto V';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Grand Theft Auto V';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Grand Theft Auto V';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Grand Theft Auto V';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Grand Theft Auto V';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Hogwarts Legacy', 'Aventura e fantasia', '2023-02-10', 249.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Hogwarts Legacy');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 990080 FROM jogos WHERE titulo='Hogwarts Legacy'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=990080)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Hogwarts Legacy';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Hogwarts Legacy';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Hogwarts Legacy';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Hogwarts Legacy';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Hogwarts Legacy';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Switch' FROM jogos WHERE titulo='Hogwarts Legacy';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Black Myth Wukong', 'Ação e fantasia', '2024-08-20', 229.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Black Myth Wukong');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 2358720 FROM jogos WHERE titulo='Black Myth Wukong'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=2358720)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Black Myth Wukong';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Black Myth Wukong';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Black Myth Wukong';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Helldivers 2', 'Tiro cooperativo', '2024-02-08', 199.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Helldivers 2');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 553850 FROM jogos WHERE titulo='Helldivers 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=553850)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Helldivers 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Helldivers 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Helldivers 2';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Palworld', 'Sobrevivência e criaturas', '2024-01-19', 88.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Palworld');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1623730 FROM jogos WHERE titulo='Palworld'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=1623730)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Palworld';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Palworld';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Palworld';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Palworld';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Resident Evil 4', 'Terror e ação', '2023-03-24', 169.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Resident Evil 4');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 2050650 FROM jogos WHERE titulo='Resident Evil 4'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=2050650)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Resident Evil 4';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Resident Evil 4';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Resident Evil 4';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Resident Evil 4';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Resident Evil 2', 'Terror de sobrevivência', '2019-01-25', 139.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Resident Evil 2');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 883710 FROM jogos WHERE titulo='Resident Evil 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=883710)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Resident Evil 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Resident Evil 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Resident Evil 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Resident Evil 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Resident Evil 2';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Lethal Company', 'Terror cooperativo', '2023-10-23', 32.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Lethal Company');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1966720 FROM jogos WHERE titulo='Lethal Company'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=1966720)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Lethal Company';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Among Us', 'Dedução social multiplayer', '2018-11-16', 14.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Among Us');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 945360 FROM jogos WHERE titulo='Among Us'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=945360)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Among Us';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Among Us';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Among Us';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Among Us';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Among Us';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Switch' FROM jogos WHERE titulo='Among Us';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Rust', 'Sobrevivência multiplayer', '2018-02-08', 93.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Rust');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 252490 FROM jogos WHERE titulo='Rust'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=252490)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Rust';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Rust';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Rust';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Rust';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Rust';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Ready or Not', 'Tiro tático cooperativo', '2023-12-13', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Ready or Not');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1144200 FROM jogos WHERE titulo='Ready or Not'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=1144200)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Ready or Not';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Ready or Not';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Ready or Not';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Fallout 4', 'RPG pós-apocalíptico', '2015-11-10', 59.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Fallout 4');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 377160 FROM jogos WHERE titulo='Fallout 4'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=377160)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Fallout 4';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Fallout 4';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Fallout 4';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Fallout 4';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Fallout 4';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Left 4 Dead 2', 'Zumbis e cooperação', '2009-11-17', 32.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Left 4 Dead 2');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 550 FROM jogos WHERE titulo='Left 4 Dead 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=550)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Left 4 Dead 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Left 4 Dead 2';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'PUBG Battlegrounds', 'Battle royale competitivo', '2017-12-21', 0.00, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='PUBG Battlegrounds');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 578080 FROM jogos WHERE titulo='PUBG Battlegrounds'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=578080)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='PUBG Battlegrounds';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='PUBG Battlegrounds';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='PUBG Battlegrounds';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='PUBG Battlegrounds';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='PUBG Battlegrounds';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Warframe', 'Ação e ficção científica', '2013-03-25', 0.00, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Warframe');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 230410 FROM jogos WHERE titulo='Warframe'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=230410)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Warframe';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Warframe';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Warframe';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Warframe';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Warframe';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Switch' FROM jogos WHERE titulo='Warframe';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Overwatch 2', 'Tiro em equipes', '2023-08-10', 0.00, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Overwatch 2');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 2357570 FROM jogos WHERE titulo='Overwatch 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=2357570)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Overwatch 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Overwatch 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Overwatch 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Overwatch 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Overwatch 2';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Switch' FROM jogos WHERE titulo='Overwatch 2';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Monster Hunter Rise', 'Caça e ação cooperativa', '2022-01-12', 139.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Monster Hunter Rise');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1446780 FROM jogos WHERE titulo='Monster Hunter Rise'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=1446780)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Monster Hunter Rise';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Monster Hunter Rise';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Monster Hunter Rise';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Monster Hunter Rise';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Monster Hunter Rise';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Switch' FROM jogos WHERE titulo='Monster Hunter Rise';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Monster Hunter Wilds', 'Aventura e caça', '2025-02-28', 279.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Monster Hunter Wilds');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 2246340 FROM jogos WHERE titulo='Monster Hunter Wilds'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=2246340)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Monster Hunter Wilds';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Monster Hunter Wilds';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Monster Hunter Wilds';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Diablo IV', 'RPG de ação', '2023-10-17', 229.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Diablo IV');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 2344520 FROM jogos WHERE titulo='Diablo IV'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=2344520)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Diablo IV';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Diablo IV';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Diablo IV';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Diablo IV';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Diablo IV';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT '7 Days to Die', 'Sobrevivência com zumbis', '2024-07-25', 74.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='7 Days to Die');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 251570 FROM jogos WHERE titulo='7 Days to Die'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=251570)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='7 Days to Die';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='7 Days to Die';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='7 Days to Die';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Rainbow Six Siege', 'Tiro tático competitivo', '2015-12-01', 79.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Rainbow Six Siege');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 359550 FROM jogos WHERE titulo='Rainbow Six Siege'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=359550)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Rainbow Six Siege';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Rainbow Six Siege';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Rainbow Six Siege';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Rainbow Six Siege';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Rainbow Six Siege';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Apex Legends', 'Battle royale em esquadrões', '2020-11-04', 0.00, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Apex Legends');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1172470 FROM jogos WHERE titulo='Apex Legends'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=1172470)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Apex Legends';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Apex Legends';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Apex Legends';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Apex Legends';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Apex Legends';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Switch' FROM jogos WHERE titulo='Apex Legends';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'DayZ', 'Sobrevivência em mundo aberto', '2018-12-13', 119.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='DayZ');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 221100 FROM jogos WHERE titulo='DayZ'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=221100)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='DayZ';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='DayZ';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='DayZ';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='DayZ';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='DayZ';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'No Mans Sky', 'Exploração espacial', '2016-08-12', 162.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='No Mans Sky');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 275850 FROM jogos WHERE titulo='No Mans Sky'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=275850)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='No Mans Sky';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='No Mans Sky';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='No Mans Sky';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='No Mans Sky';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='No Mans Sky';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Switch' FROM jogos WHERE titulo='No Mans Sky';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Subnautica', 'Exploração e sobrevivência subaquática', '2018-01-23', 69.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Subnautica');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 264710 FROM jogos WHERE titulo='Subnautica'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=264710)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Subnautica';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Subnautica';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Subnautica';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Subnautica';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Subnautica';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Switch' FROM jogos WHERE titulo='Subnautica';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'It Takes Two', 'Aventura cooperativa', '2021-03-26', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='It Takes Two');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1426210 FROM jogos WHERE titulo='It Takes Two'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=1426210)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='It Takes Two';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='It Takes Two';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='It Takes Two';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='It Takes Two';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='It Takes Two';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Switch' FROM jogos WHERE titulo='It Takes Two';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Cuphead', 'Plataforma e chefes desafiadores', '2017-09-29', 36.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Cuphead');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 268910 FROM jogos WHERE titulo='Cuphead'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=268910)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Cuphead';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Cuphead';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Cuphead';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Cuphead';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Cuphead';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Switch' FROM jogos WHERE titulo='Cuphead';

INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Dying Light 2 Stay Human', 'Ação e sobrevivência', '2022-02-04', 199.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo='Dying Light 2 Stay Human');
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 534380 FROM jogos WHERE titulo='Dying Light 2 Stay Human'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id=jogos.id)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id=534380)
ORDER BY id LIMIT 1;
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PC' FROM jogos WHERE titulo='Dying Light 2 Stay Human';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS4' FROM jogos WHERE titulo='Dying Light 2 Stay Human';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'PS5' FROM jogos WHERE titulo='Dying Light 2 Stay Human';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox One' FROM jogos WHERE titulo='Dying Light 2 Stay Human';
INSERT IGNORE INTO plataformas_jogos (jogo_id, plataforma)
SELECT id, 'Xbox Series' FROM jogos WHERE titulo='Dying Light 2 Stay Human';

COMMIT;
