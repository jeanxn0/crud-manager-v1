package model.dao;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import model.ModelException;

public class AccountDAO {
    public boolean register(String email, String hash) throws ModelException {
        try (var connection = MySQLConnectionFactory.getConnection();
             var statement = connection.prepareStatement("INSERT INTO contas (email, senha_hash) VALUES (?, ?)")) {
            statement.setString(1, email);
            statement.setString(2, hash);
            return statement.executeUpdate() == 1;
        } catch (SQLIntegrityConstraintViolationException e) {
            return false;
        } catch (SQLException e) {
            throw new ModelException("Erro ao cadastrar conta", e);
        }
    }

    public String findHash(String email) throws ModelException {
        try (var connection = MySQLConnectionFactory.getConnection();
             var statement = connection.prepareStatement("SELECT senha_hash FROM contas WHERE email = ?")) {
            statement.setString(1, email);
            try (var rows = statement.executeQuery()) {
                return rows.next() ? rows.getString(1) : null;
            }
        } catch (SQLException e) {
            throw new ModelException("Erro ao buscar conta", e);
        }
    }
}
