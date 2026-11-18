package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Migra posts e companies para suportar vinculo com contas da loja.
 * Mantem user_id para registros antigos, sem apagar dados.
 */
public final class CustomerRelationsSchema {
    private CustomerRelationsSchema() {
    }

    public static void ensure(Connection connection, String table) throws SQLException {
        if (!"posts".equals(table) && !"companies".equals(table)) {
            throw new IllegalArgumentException("Tabela nao autorizada");
        }
        CustomerProfileSchema.ensure(connection);
        makeLegacyUserOptional(connection, table);
        addAccountColumn(connection, table);
        addAccountForeignKey(connection, table);
    }

    private static void makeLegacyUserOptional(Connection connection, String table)
            throws SQLException {
        String sql = "SELECT IS_NULLABLE FROM information_schema.COLUMNS "
                + "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ? AND COLUMN_NAME = 'user_id'";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, table);
            try (ResultSet rows = statement.executeQuery()) {
                if (!rows.next()) {
                    throw new SQLException("Coluna user_id nao encontrada na tabela " + table);
                }
                if ("YES".equals(rows.getString(1))) return;
            }
        }
        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate("ALTER TABLE " + table + " MODIFY COLUMN user_id INT NULL");
        }
    }

    private static void addAccountColumn(Connection connection, String table) throws SQLException {
        String sql = "SELECT COUNT(*) FROM information_schema.COLUMNS "
                + "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ? AND COLUMN_NAME = 'conta_id'";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, table);
            try (ResultSet rows = statement.executeQuery()) {
                if (rows.next() && rows.getInt(1) > 0) return;
            }
        }
        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate("ALTER TABLE " + table + " ADD COLUMN conta_id INT NULL");
        } catch (SQLException e) {
            if (e.getErrorCode() != 1060) throw e;
        }
    }

    private static void addAccountForeignKey(Connection connection, String table)
            throws SQLException {
        String sql = "SELECT COUNT(*) FROM information_schema.KEY_COLUMN_USAGE "
                + "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ? "
                + "AND COLUMN_NAME = 'conta_id' AND REFERENCED_TABLE_NAME = 'contas'";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, table);
            try (ResultSet rows = statement.executeQuery()) {
                if (rows.next() && rows.getInt(1) > 0) return;
            }
        }
        String constraint = "posts".equals(table) ? "fk_posts_conta" : "fk_companies_conta";
        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate("ALTER TABLE " + table + " ADD CONSTRAINT " + constraint
                    + " FOREIGN KEY (conta_id) REFERENCES contas(id)");
        } catch (SQLException e) {
            // Requisicoes concorrentes podem ter criado a chave estrangeira.
            if (e.getErrorCode() != 1826 && e.getErrorCode() != 1061) throw e;
        }
    }
}
