USE crud_manager;
START TRANSACTION;
INSERT INTO users (nome, sexo, email)
SELECT 'Catálogo da loja', NULL, 'catalogo@example.invalid'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'catalogo@example.invalid');
SET @responsavel = (SELECT MIN(id) FROM users WHERE email = 'catalogo@example.invalid');
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Elden Ring', 'Jogo de PC', '2022-02-25', 229.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Elden Ring')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1245620);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1245620 FROM jogos WHERE titulo = 'Elden Ring'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1245620)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Cyberpunk 2077', 'Jogo de PC', '2020-12-10', 199.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Cyberpunk 2077')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1091500);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1091500 FROM jogos WHERE titulo = 'Cyberpunk 2077'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1091500)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'The Witcher 3', 'Jogo de PC', '2015-05-19', 129.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'The Witcher 3')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 292030);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 292030 FROM jogos WHERE titulo = 'The Witcher 3'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 292030)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Red Dead Redemption 2', 'Jogo de PC', '2019-12-05', 249.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Red Dead Redemption 2')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1174180);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1174180 FROM jogos WHERE titulo = 'Red Dead Redemption 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1174180)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Baldur’s Gate 3', 'Jogo de PC', '2023-08-03', 199.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Baldur’s Gate 3')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1086940);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1086940 FROM jogos WHERE titulo = 'Baldur’s Gate 3'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1086940)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Hollow Knight', 'Jogo de PC', '2017-02-24', 46.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Hollow Knight')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 367520);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 367520 FROM jogos WHERE titulo = 'Hollow Knight'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 367520)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Stardew Valley', 'Jogo de PC', '2016-02-26', 24.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Stardew Valley')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 413150);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 413150 FROM jogos WHERE titulo = 'Stardew Valley'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 413150)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Terraria', 'Jogo de PC', '2011-05-16', 32.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Terraria')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 105600);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 105600 FROM jogos WHERE titulo = 'Terraria'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 105600)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Hades', 'Jogo de PC', '2020-09-17', 73.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Hades')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1145360);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1145360 FROM jogos WHERE titulo = 'Hades'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1145360)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Dead Cells', 'Jogo de PC', '2018-08-07', 59.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Dead Cells')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 588650);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 588650 FROM jogos WHERE titulo = 'Dead Cells'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 588650)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Celeste', 'Jogo de PC', '2018-01-25', 36.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Celeste')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 504230);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 504230 FROM jogos WHERE titulo = 'Celeste'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 504230)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'The Binding of Isaac Rebirth', 'Jogo de PC', '2014-11-04', 55.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'The Binding of Isaac Rebirth')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 250900);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 250900 FROM jogos WHERE titulo = 'The Binding of Isaac Rebirth'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 250900)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Portal 2', 'Jogo de PC', '2011-04-19', 32.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Portal 2')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 620);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 620 FROM jogos WHERE titulo = 'Portal 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 620)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Half-Life 2', 'Jogo de PC', '2004-11-16', 32.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Half-Life 2')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 220);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 220 FROM jogos WHERE titulo = 'Half-Life 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 220)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Portal', 'Jogo de PC', '2007-10-10', 32.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Portal')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 400);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 400 FROM jogos WHERE titulo = 'Portal'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 400)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Dota 2', 'Jogo de PC', '2013-07-09', 0.00, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Dota 2')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 570);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 570 FROM jogos WHERE titulo = 'Dota 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 570)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Counter-Strike 2', 'Jogo de PC', '2023-09-27', 0.00, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Counter-Strike 2')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 730);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 730 FROM jogos WHERE titulo = 'Counter-Strike 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 730)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Team Fortress 2', 'Jogo de PC', '2007-10-10', 0.00, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Team Fortress 2')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 440);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 440 FROM jogos WHERE titulo = 'Team Fortress 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 440)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Deep Rock Galactic', 'Jogo de PC', '2020-05-13', 89.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Deep Rock Galactic')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 548430);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 548430 FROM jogos WHERE titulo = 'Deep Rock Galactic'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 548430)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Risk of Rain 2', 'Jogo de PC', '2020-08-11', 73.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Risk of Rain 2')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 632360);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 632360 FROM jogos WHERE titulo = 'Risk of Rain 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 632360)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Valheim', 'Jogo de PC', '2021-02-02', 59.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Valheim')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 892970);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 892970 FROM jogos WHERE titulo = 'Valheim'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 892970)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Satisfactory', 'Jogo de PC', '2024-09-10', 149.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Satisfactory')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 526870);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 526870 FROM jogos WHERE titulo = 'Satisfactory'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 526870)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Factorio', 'Jogo de PC', '2020-08-14', 129.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Factorio')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 427520);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 427520 FROM jogos WHERE titulo = 'Factorio'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 427520)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'RimWorld', 'Jogo de PC', '2018-10-17', 109.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'RimWorld')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 294100);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 294100 FROM jogos WHERE titulo = 'RimWorld'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 294100)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Oxygen Not Included', 'Jogo de PC', '2019-07-30', 59.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Oxygen Not Included')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 457140);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 457140 FROM jogos WHERE titulo = 'Oxygen Not Included'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 457140)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Phasmophobia', 'Jogo de PC', '2020-09-18', 59.99, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Phasmophobia')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 739630);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 739630 FROM jogos WHERE titulo = 'Phasmophobia'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 739630)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Sons of the Forest', 'Jogo de PC', '2024-02-22', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Sons of the Forest')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1326470);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1326470 FROM jogos WHERE titulo = 'Sons of the Forest'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1326470)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Ori and the Will of the Wisps', 'Jogo de PC', '2020-03-11', 129.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Ori and the Will of the Wisps')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1057090);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1057090 FROM jogos WHERE titulo = 'Ori and the Will of the Wisps'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1057090)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Fallout New Vegas', 'Jogo de PC', '2010-10-19', 39.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Fallout New Vegas')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 22380);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 22380 FROM jogos WHERE titulo = 'Fallout New Vegas'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 22380)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'The Elder Scrolls V Skyrim', 'Jogo de PC', '2011-11-11', 59.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'The Elder Scrolls V Skyrim')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 72850);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 72850 FROM jogos WHERE titulo = 'The Elder Scrolls V Skyrim'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 72850)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'God of War', 'Jogo de PC', '2018-04-20', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'God of War')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1593500);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1593500 FROM jogos WHERE titulo = 'God of War'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1593500)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'God of War Ragnarök', 'Jogo de PC', '2022-11-09', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'God of War Ragnarök')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 2322010);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 2322010 FROM jogos WHERE titulo = 'God of War Ragnarök'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 2322010)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Marvel’s Spider-Man Remastered', 'Jogo de PC', '2020-11-12', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Marvel’s Spider-Man Remastered')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1817070);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1817070 FROM jogos WHERE titulo = 'Marvel’s Spider-Man Remastered'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1817070)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Ghost of Tsushima Director’s Cut', 'Jogo de PC', '2021-08-20', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Ghost of Tsushima Director’s Cut')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 2215430);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 2215430 FROM jogos WHERE titulo = 'Ghost of Tsushima Director’s Cut'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 2215430)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Forza Horizon 5', 'Jogo de PC', '2021-11-09', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Forza Horizon 5')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1551360);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1551360 FROM jogos WHERE titulo = 'Forza Horizon 5'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1551360)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Halo Infinite', 'Jogo de PC', '2021-12-08', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Halo Infinite')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1240440);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1240440 FROM jogos WHERE titulo = 'Halo Infinite'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1240440)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Sea of Thieves', 'Jogo de PC', '2018-03-20', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Sea of Thieves')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1172620);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1172620 FROM jogos WHERE titulo = 'Sea of Thieves'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1172620)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Starfield', 'Jogo de PC', '2023-09-06', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Starfield')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1716740);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1716740 FROM jogos WHERE titulo = 'Starfield'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1716740)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Rogue Legacy 2', 'Jogo de PC', '2022-04-28', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Rogue Legacy 2')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1253920);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1253920 FROM jogos WHERE titulo = 'Rogue Legacy 2'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1253920)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Lies of P', 'Jogo de PC', '2023-09-19', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Lies of P')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1627720);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1627720 FROM jogos WHERE titulo = 'Lies of P'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1627720)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Dave the Diver', 'Jogo de PC', '2023-06-28', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Dave the Diver')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1868140);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1868140 FROM jogos WHERE titulo = 'Dave the Diver'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1868140)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id)
SELECT 'Mirror’s Edge Catalyst', 'Jogo de PC', '2016-06-07', 99.90, @responsavel
WHERE NOT EXISTS (SELECT 1 FROM jogos WHERE titulo = 'Mirror’s Edge Catalyst')
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1233570);
INSERT INTO capas_jogos (jogo_id, steam_app_id)
SELECT id, 1233570 FROM jogos WHERE titulo = 'Mirror’s Edge Catalyst'
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE steam_app_id = 1233570)
  AND NOT EXISTS (SELECT 1 FROM capas_jogos WHERE jogo_id = jogos.id)
ORDER BY id LIMIT 1;
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 1593500
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 1593500
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 2322010
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 2322010
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 1817070
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 2215430
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 2215430
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 1551360
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox Series' FROM capas_jogos c WHERE steam_app_id = 1551360
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox Series');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 1551360
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 1240440
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox Series' FROM capas_jogos c WHERE steam_app_id = 1240440
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox Series');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 1172620
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox Series' FROM capas_jogos c WHERE steam_app_id = 1172620
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox Series');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 1172620
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox Series' FROM capas_jogos c WHERE steam_app_id = 1716740
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox Series');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Switch' FROM capas_jogos c WHERE steam_app_id = 1253920
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Switch');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 1253920
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 1253920
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 1253920
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox Series' FROM capas_jogos c WHERE steam_app_id = 1253920
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox Series');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 1627720
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 1627720
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 1627720
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox Series' FROM capas_jogos c WHERE steam_app_id = 1627720
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox Series');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Switch' FROM capas_jogos c WHERE steam_app_id = 1868140
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Switch');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 1868140
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 1868140
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 1233570
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 1233570
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 1245620
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 1245620
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 1245620
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox Series' FROM capas_jogos c WHERE steam_app_id = 1245620
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox Series');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 1091500
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 1091500
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 1091500
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox Series' FROM capas_jogos c WHERE steam_app_id = 1091500
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox Series');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 292030
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 292030
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 292030
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox Series' FROM capas_jogos c WHERE steam_app_id = 292030
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox Series');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Switch' FROM capas_jogos c WHERE steam_app_id = 292030
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Switch');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 1174180
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 1174180
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 1086940
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox Series' FROM capas_jogos c WHERE steam_app_id = 1086940
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox Series');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 367520
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 367520
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Switch' FROM capas_jogos c WHERE steam_app_id = 367520
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Switch');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 413150
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 413150
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Switch' FROM capas_jogos c WHERE steam_app_id = 413150
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Switch');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 105600
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 105600
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Switch' FROM capas_jogos c WHERE steam_app_id = 105600
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Switch');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 1145360
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 1145360
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 1145360
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox Series' FROM capas_jogos c WHERE steam_app_id = 1145360
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox Series');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Switch' FROM capas_jogos c WHERE steam_app_id = 1145360
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Switch');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 588650
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS5' FROM capas_jogos c WHERE steam_app_id = 588650
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS5');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 588650
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Switch' FROM capas_jogos c WHERE steam_app_id = 588650
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Switch');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 504230
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Xbox One' FROM capas_jogos c WHERE steam_app_id = 504230
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Xbox One');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'Switch' FROM capas_jogos c WHERE steam_app_id = 504230
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'Switch');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PS4' FROM capas_jogos c WHERE steam_app_id = 250900
  AND NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PS4');
INSERT INTO plataformas_jogos (jogo_id, plataforma)
SELECT jogo_id, 'PC' FROM capas_jogos c
WHERE NOT EXISTS (SELECT 1 FROM plataformas_jogos p WHERE p.jogo_id = c.jogo_id AND p.plataforma = 'PC');
COMMIT;
