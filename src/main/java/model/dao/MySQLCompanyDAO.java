package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Company;
import model.CustomerAccount;
import model.ModelException;
import model.User;

/** CRUD de empresas ligado aos cadastros reais de contas. */
public class MySQLCompanyDAO implements CompanyDAO {

    private static final String SELECT = "SELECT c.id, c.name, c.role, c.start, c.end, "
            + "c.user_id, c.conta_id, a.nome AS conta_nome, a.sexo AS conta_sexo, "
            + "a.email AS conta_email, u.nome AS user_nome, u.sexo AS user_sexo, "
            + "u.email AS user_email FROM companies c "
            + "LEFT JOIN contas a ON a.id = c.conta_id "
            + "LEFT JOIN users u ON u.id = c.user_id ";

    @Override
    public boolean save(Company company) throws ModelException {
        String sql = "INSERT INTO companies (name, role, start, `end`, user_id, conta_id) "
                + "VALUES (?, ?, ?, ?, NULL, ?)";
        try (Connection connection = open();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            setFields(statement, company);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new ModelException("Falha ao cadastrar empresa", e);
        }
    }

    @Override
    public boolean update(Company company) throws ModelException {
        String sql = "UPDATE companies SET name=?, role=?, start=?, `end`=?, "
                + "user_id=NULL, conta_id=? WHERE id=?";
        try (Connection connection = open();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            setFields(statement, company);
            statement.setInt(6, company.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new ModelException("Falha ao atualizar empresa", e);
        }
    }

    private void setFields(PreparedStatement statement, Company company) throws SQLException {
        statement.setString(1, company.getName());
        statement.setString(2, company.getRole());
        statement.setDate(3, new java.sql.Date(
                (company.getStart() == null ? new Date() : company.getStart()).getTime()));
        if (company.getEnd() == null) {
            statement.setNull(4, Types.DATE);
        } else {
            statement.setDate(4, new java.sql.Date(company.getEnd().getTime()));
        }
        statement.setInt(5, company.getAccountId());
    }

    @Override
    public boolean delete(Company company) throws ModelException {
        try (Connection connection = open();
             PreparedStatement statement = connection.prepareStatement(
                     "DELETE FROM companies WHERE id=?")) {
            statement.setInt(1, company.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new ModelException("Falha ao excluir empresa", e);
        }
    }

    @Override
    public List<Company> listAll() throws ModelException {
        List<Company> rows = new ArrayList<>();
        try (Connection connection = open();
             PreparedStatement statement = connection.prepareStatement(
                     SELECT + "ORDER BY c.id DESC");
             ResultSet results = statement.executeQuery()) {
            while (results.next()) rows.add(from(results));
            return rows;
        } catch (SQLException e) {
            throw new ModelException("Falha ao listar empresas", e);
        }
    }

    @Override
    public Company findById(int id) throws ModelException {
        try (Connection connection = open();
             PreparedStatement statement = connection.prepareStatement(
                     SELECT + "WHERE c.id=?")) {
            statement.setInt(1, id);
            try (ResultSet results = statement.executeQuery()) {
                return results.next() ? from(results) : null;
            }
        } catch (SQLException e) {
            throw new ModelException("Falha ao encontrar empresa", e);
        }
    }

    private Connection open() throws ModelException, SQLException {
        Connection connection = MySQLConnectionFactory.getConnection();
        try {
            CustomerRelationsSchema.ensure(connection, "companies");
            return connection;
        } catch (SQLException e) {
            connection.close();
            throw e;
        }
    }

    private Company from(ResultSet rs) throws SQLException {
        Company company = new Company(rs.getInt("id"));
        company.setName(rs.getString("name"));
        company.setRole(rs.getString("role"));
        company.setStart(rs.getDate("start"));
        company.setEnd(rs.getDate("end"));
        int accountId = rs.getInt("conta_id");
        if (!rs.wasNull()) {
            company.setAccountId(accountId);
            company.setAccount(new CustomerAccount(accountId,
                    rs.getString("conta_nome"), rs.getString("conta_sexo"),
                    rs.getString("conta_email")));
        }
        int legacyId = rs.getInt("user_id");
        if (!rs.wasNull()) {
            User legacy = new User(legacyId);
            legacy.setName(rs.getString("user_nome"));
            legacy.setGender(rs.getString("user_sexo"));
            legacy.setEmail(rs.getString("user_email"));
            company.setUser(legacy);
        }
        return company;
    }
}
