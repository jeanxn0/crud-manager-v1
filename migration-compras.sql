-- Execute APOS schema.sql no banco crud_manager.
-- Seguro para executar novamente: so altera a tabela quando necessario.
USE crud_manager;
SET @has_col = (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'vendas' AND COLUMN_NAME = 'conta_id'
);
SET @ddl = IF(@has_col = 0,
  'ALTER TABLE vendas ADD COLUMN conta_id INT NULL',
  'SELECT 1'
);
PREPARE upgrade_statement FROM @ddl;
EXECUTE upgrade_statement;
DEALLOCATE PREPARE upgrade_statement;

SET @has_fk = (
  SELECT COUNT(*) FROM information_schema.TABLE_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE() AND TABLE_NAME = 'vendas'
    AND CONSTRAINT_NAME = 'fk_vendas_conta' AND CONSTRAINT_TYPE = 'FOREIGN KEY'
);
SET @ddl = IF(@has_fk = 0,
  'ALTER TABLE vendas ADD CONSTRAINT fk_vendas_conta FOREIGN KEY (conta_id) REFERENCES contas(id) ON DELETE SET NULL',
  'SELECT 1'
);
PREPARE upgrade_statement FROM @ddl;
EXECUTE upgrade_statement;
DEALLOCATE PREPARE upgrade_statement;
