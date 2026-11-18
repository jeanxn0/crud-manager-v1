-- Execute uma vez (ou repita sem perder dados) no MySQL Workbench.
-- Preserva registros de contas, posts e empresas que ja existem.
-- A aplicacao tambem tenta aplicar esta migracao automaticamente se tiver permissao.
USE crud_manager;

DROP PROCEDURE IF EXISTS migrar_perfis_e_vinculos;
DELIMITER $$

CREATE PROCEDURE migrar_perfis_e_vinculos()
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'contas' AND COLUMN_NAME = 'nome'
    ) THEN
        ALTER TABLE contas ADD COLUMN nome VARCHAR(150) NULL;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'contas' AND COLUMN_NAME = 'sexo'
    ) THEN
        ALTER TABLE contas ADD COLUMN sexo VARCHAR(30) NULL;
    END IF;

    IF EXISTS (
        SELECT 1 FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'posts'
            AND COLUMN_NAME = 'user_id' AND IS_NULLABLE = 'NO'
    ) THEN
        ALTER TABLE posts MODIFY COLUMN user_id INT NULL;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'posts' AND COLUMN_NAME = 'conta_id'
    ) THEN
        ALTER TABLE posts ADD COLUMN conta_id INT NULL;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.KEY_COLUMN_USAGE
        WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'posts'
            AND COLUMN_NAME = 'conta_id' AND REFERENCED_TABLE_NAME = 'contas'
    ) THEN
        ALTER TABLE posts ADD CONSTRAINT fk_posts_conta
            FOREIGN KEY (conta_id) REFERENCES contas(id);
    END IF;

    IF EXISTS (
        SELECT 1 FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'companies'
            AND COLUMN_NAME = 'user_id' AND IS_NULLABLE = 'NO'
    ) THEN
        ALTER TABLE companies MODIFY COLUMN user_id INT NULL;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'companies' AND COLUMN_NAME = 'conta_id'
    ) THEN
        ALTER TABLE companies ADD COLUMN conta_id INT NULL;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.KEY_COLUMN_USAGE
        WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'companies'
            AND COLUMN_NAME = 'conta_id' AND REFERENCED_TABLE_NAME = 'contas'
    ) THEN
        ALTER TABLE companies ADD CONSTRAINT fk_companies_conta
            FOREIGN KEY (conta_id) REFERENCES contas(id);
    END IF;
END$$

DELIMITER ;
CALL migrar_perfis_e_vinculos();
DROP PROCEDURE migrar_perfis_e_vinculos;
