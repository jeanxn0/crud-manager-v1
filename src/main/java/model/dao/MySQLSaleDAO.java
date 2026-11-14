package model.dao;

import java.sql.*;
import java.util.*;
import java.time.*;
import java.math.BigDecimal;
import model.Sale;
import model.ModelException;

public class MySQLSaleDAO implements SaleDAO {
    public List<Sale> list() throws ModelException {
        List<Sale> rows = new ArrayList<>();
        try (Connection connection = MySQLConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT * FROM vendas ORDER BY id DESC");
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                rows.add(new Sale(rs.getInt("id"), rs.getObject("jogo_id", Integer.class), rs.getObject("quantidade", Integer.class), rs.getObject("valor_total", BigDecimal.class), rs.getObject("data_venda", LocalDateTime.class), rs.getObject("status_pagamento", String.class)));
            }
            return rows;
        } catch (SQLException e) {
            throw new ModelException("Erro ao listar registros", e);
        }
    }

    public Map<Integer, String> options() throws ModelException {
        Map<Integer, String> labels = new LinkedHashMap<>();
        try (Connection connection = MySQLConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT id,titulo FROM jogos ORDER BY titulo");
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) labels.put(rs.getInt(1), rs.getString(2));
            return labels;
        } catch (SQLException e) {
            throw new ModelException("Erro ao carregar opções", e);
        }
    }

    public void save(Sale item) throws ModelException {
        boolean insert = item.id() == 0;
        String sql = insert ? "INSERT INTO vendas (jogo_id, quantidade, valor_total, data_venda, status_pagamento) VALUES (?, ?, ?, ?, ?)"
                            : "UPDATE vendas SET jogo_id=?, quantidade=?, valor_total=?, data_venda=?, status_pagamento=? WHERE id=?";
        try (Connection connection = MySQLConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, item.jogo_id());
            statement.setObject(2, item.quantidade());
            statement.setObject(3, item.valor_total());
            statement.setObject(4, item.data_venda());
            statement.setObject(5, item.status_pagamento());
            if (!insert) statement.setInt(6, item.id());
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new ModelException("Erro ao salvar registro", e);
        }
    }

    public void delete(int id) throws ModelException {
        try (Connection connection = MySQLConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement("DELETE FROM vendas WHERE id=?")) {
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new ModelException("Erro ao excluir registro", e);
        }
    }
}
