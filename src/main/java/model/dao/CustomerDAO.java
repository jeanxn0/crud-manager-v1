package model.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.CustomerAccount;
import model.ModelException;

/**
 * Leitura das contas criadas pela tela de cadastro da loja.
 * A tabela 'contas' e independente da tabela 'users'.
 */
public class CustomerDAO {

    public List<CustomerAccount> list() throws ModelException {
        String sql = "SELECT id, email FROM contas ORDER BY id DESC";
        List<CustomerAccount> customers = new ArrayList<>();

        try (var connection = MySQLConnectionFactory.getConnection();
             var statement = connection.prepareStatement(sql);
             var results = statement.executeQuery()) {

            while (results.next()) {
                customers.add(new CustomerAccount(
                        results.getInt("id"),
                        results.getString("email")
                ));
            }

            return customers;
        } catch (SQLException e) {
            throw new ModelException("Erro ao listar clientes cadastrados", e);
        }
    }
}
