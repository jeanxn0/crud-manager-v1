package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Atualiza contas sem descartar clientes antigos.
 * As colunas extras podem ficar NULL para os cadastros antigos.
 */
public final class CustomerProfileSchema {
    private CustomerProfileSchema() {
    }

    public static void ensure(Connection connection) throws SQLException {
        addColumnIfMissing(connection, "nome", "VARCHAR(150) NULL");
        addColumnIfMissing(connection, "sexo", "VARCHAR(30) NULL");
    }

    private static void addColumnIfMissing(Connection connection, String column, String type)
            throws SQLException {
        String sql = "SELECT COUNT(*) FROM information_schema.COLUMNS "
                + "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'contas' AND COLUMN_NAME = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, column);
            try (ResultSet result = statement.executeQuery()) {
                if (result.next() && result.getInt(1) != 0) {
                    return;
                }
            }
        }

        // Apenas constantes locais são utilizadas no DDL.
        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate("ALTER TABLE contas ADD COLUMN " + column + " " + type);
        } catch (SQLException e) {
            if (e.getErrorCode() != 1060) {
                throw e;
            }
        }
    }
}
