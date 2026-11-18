package model.dao;

import java.sql.*;
import java.security.GeneralSecurityException;
import model.ModelException;

/**
 * Administradores são armazenados separadamente das contas de clientes.
 * A primeira conta de desenvolvimento é criada automaticamente no banco
 * SOMENTE quando alguém tenta entrar com "admin" a partir do localhost.
 */
public final class AdminDAO {
    public record AdminAccount(int id, String username, String passwordHash, boolean mustChangePassword) {}

    public AdminAccount findOrInitialize(String username, boolean localRequest, String initialHash)
            throws ModelException {
        try (Connection connection = MySQLConnectionFactory.getConnection()) {
            try (Statement statement = connection.createStatement()) {
                statement.executeUpdate(
                    "CREATE TABLE IF NOT EXISTS administradores (" +
                    "id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, " +
                    "username VARCHAR(50) NOT NULL UNIQUE, " +
                    "senha_hash VARCHAR(255) NOT NULL, " +
                    "trocar_senha BOOLEAN NOT NULL DEFAULT TRUE" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");
            }
            AdminAccount found = select(connection, username);
            if (found != null) return found;

            if (!localRequest || !"admin".equals(username) || initialHash == null) return null;
            try (PreparedStatement statement = connection.prepareStatement(
                    "INSERT INTO administradores (username, senha_hash, trocar_senha) " +
                    "VALUES ('admin', ?, TRUE)")) {
                statement.setString(1, initialHash);
                statement.executeUpdate();
            } catch (SQLIntegrityConstraintViolationException ignored) {
                // Duas requisições podem tentar criar a primeira conta simultaneamente.
            }
            return select(connection, username);
        } catch (SQLException e) {
            throw new ModelException("Não foi possível carregar a conta administrativa", e);
        }
    }

    private AdminAccount select(Connection connection, String username) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(
                "SELECT id, username, senha_hash, trocar_senha FROM administradores WHERE username = ?")) {
            statement.setString(1, username);
            try (ResultSet rows = statement.executeQuery()) {
                if (!rows.next()) return null;
                return new AdminAccount(rows.getInt("id"), rows.getString("username"),
                        rows.getString("senha_hash"), rows.getBoolean("trocar_senha"));
            }
        }
    }

    public boolean changePassword(int id, String previousHash, String newHash)
            throws ModelException {
        try (Connection connection = MySQLConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                    "UPDATE administradores SET senha_hash=?, trocar_senha=FALSE " +
                    "WHERE id=? AND senha_hash=? AND trocar_senha=TRUE")) {
            statement.setString(1, newHash);
            statement.setInt(2, id);
            statement.setString(3, previousHash);
            return statement.executeUpdate() == 1;
        } catch (SQLException e) {
            throw new ModelException("Não foi possível trocar a senha do administrador", e);
        }
    }
}
