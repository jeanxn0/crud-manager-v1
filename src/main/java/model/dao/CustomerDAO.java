package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.CustomerAccount;
import model.ModelException;


public class CustomerDAO {

    public List<CustomerAccount> list() throws ModelException {
        List<CustomerAccount> customers = new ArrayList<>();
        try (Connection connection = MySQLConnectionFactory.getConnection()) {
            CustomerProfileSchema.ensure(connection);
            String sql = "SELECT id, nome, sexo, email FROM contas ORDER BY id DESC";
            try (PreparedStatement statement = connection.prepareStatement(sql);
                 ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    customers.add(new CustomerAccount(
                            rs.getInt("id"), rs.getString("nome"),
                            rs.getString("sexo"), rs.getString("email")));
                }
            }
            return customers;
        } catch (SQLException e) {
            throw new ModelException("Erro ao carregar clientes cadastrados", e);
        }
    }
}
