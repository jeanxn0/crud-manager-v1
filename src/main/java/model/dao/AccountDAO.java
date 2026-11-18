package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import model.ModelException;


public class AccountDAO {

    public boolean register(String nome, String sexo, String email, String hash)
            throws ModelException {
        try (Connection connection = MySQLConnectionFactory.getConnection()) {
            CustomerProfileSchema.ensure(connection);
            String sql = "INSERT INTO contas (nome, sexo, email, senha_hash) VALUES (?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, nome);
                statement.setString(2, sexo);
                statement.setString(3, email);
                statement.setString(4, hash);
                return statement.executeUpdate() == 1;
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            return false;
        } catch (SQLException e) {
            throw new ModelException("Erro ao cadastrar conta no MySQL", e);
        }
    }

    public String findHash(String email) throws ModelException {
        try (Connection connection = MySQLConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT senha_hash FROM contas WHERE email = ?")) {
            statement.setString(1, email);
            try (ResultSet rows = statement.executeQuery()) {
                return rows.next() ? rows.getString(1) : null;
            }
        } catch (SQLException e) {
            throw new ModelException("Erro ao buscar conta", e);
        }
    }

    public Integer findId(String email) throws ModelException {
        try (Connection connection = MySQLConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT id FROM contas WHERE email = ?")) {
            statement.setString(1, email);
            try (ResultSet rows = statement.executeQuery()) {
                return rows.next() ? rows.getInt(1) : null;
            }
        } catch (SQLException e) {
            throw new ModelException("Erro ao identificar conta", e);
        }
    }
}
