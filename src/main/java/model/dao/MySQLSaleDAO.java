package model.dao;

import java.sql.*;
import java.util.*;
import java.time.*;
import java.math.BigDecimal;
import model.Sale;
import model.ModelException;

public class MySQLSaleDAO implements SaleDAO {
    private Sale from(ResultSet rs) throws SQLException {
        return new Sale(rs.getInt("id"), rs.getInt("jogo_id"), rs.getInt("quantidade"),
                rs.getBigDecimal("valor_total"), rs.getTimestamp("data_venda").toLocalDateTime(),
                rs.getString("status_pagamento"), readAccountId(rs));
    }


    
    
    private Integer readAccountId(ResultSet rs) throws SQLException {
        try {
            return (Integer) rs.getObject("conta_id");
        } catch (SQLException e) {
            if (e.getErrorCode() == 0 && e.getMessage() != null
                    && e.getMessage().toLowerCase(java.util.Locale.ROOT).contains("column")) {
                return null;
            }
            
            if (e.getMessage() != null &&
                    (e.getMessage().contains("conta_id") || e.getMessage().contains("Column"))) {
                return null;
            }
            throw e;
        }
    }

    public List<Sale> list() throws ModelException {
        List<Sale> rows = new ArrayList<>();
        try (Connection conn = MySQLConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM vendas ORDER BY id DESC");
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) rows.add(from(rs));
            return rows;
        } catch (SQLException e) {
            throw new ModelException("Erro ao listar vendas. Execute migration-compras.sql.", e);
        }
    }

    public List<Sale> listMine(int accountId) throws ModelException {
        List<Sale> rows = new ArrayList<>();
        try (Connection conn = MySQLConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT * FROM vendas WHERE conta_id = ? ORDER BY id DESC")) {
            stmt.setInt(1, accountId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) rows.add(from(rs));
            }
            return rows;
        } catch (SQLException e) {
            throw new ModelException("Erro ao consultar suas compras. Execute migration-compras.sql.", e);
        }
    }

    public Map<Integer, String> options() throws ModelException {
        Map<Integer, String> labels = new LinkedHashMap<>();
        try (Connection conn = MySQLConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT id, titulo FROM jogos ORDER BY titulo");
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) labels.put(rs.getInt(1), rs.getString(2));
            return labels;
        } catch (SQLException e) {
            throw new ModelException("Erro ao carregar jogos", e);
        }
    }

    public Map<Integer, String> buyers() throws ModelException {
        Map<Integer, String> labels = new LinkedHashMap<>();
        try (Connection conn = MySQLConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT id, email FROM contas ORDER BY email");
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) labels.put(rs.getInt(1), rs.getString(2));
            return labels;
        } catch (SQLException e) {
            throw new ModelException("Erro ao carregar compradores", e);
        }
    }

    
    public boolean purchase(int gameId, int quantity, int accountId) throws ModelException {
        if (gameId <= 0 || quantity < 1 || quantity > 10 || accountId <= 0) {
            throw new IllegalArgumentException("Pedido inválido");
        }
        String sql = "INSERT INTO vendas (jogo_id, quantidade, valor_total, data_venda, status_pagamento, conta_id) "
                + "SELECT id, ?, ROUND(preco * ?, 2), NOW(), 'PENDENTE', ? "
                + "FROM jogos WHERE id = ? AND preco >= 0";
        try (Connection conn = MySQLConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, quantity);
            stmt.setInt(3, accountId);
            stmt.setInt(4, gameId);
            return stmt.executeUpdate() == 1;
        } catch (SQLException e) {
            throw new ModelException("Não foi possível registrar a compra", e);
        }
    }

    public void save(Sale item) throws ModelException {
        boolean insert = item.id() == 0;
        String sql = insert ? "INSERT INTO vendas (jogo_id, quantidade, valor_total, data_venda, status_pagamento) VALUES (?, ?, ?, ?, ?)"
                            : "UPDATE vendas SET jogo_id=?, quantidade=?, valor_total=?, data_venda=?, status_pagamento=? WHERE id=?";
        try (Connection conn = MySQLConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setObject(1, item.jogo_id());
            stmt.setObject(2, item.quantidade());
            stmt.setObject(3, item.valor_total());
            stmt.setObject(4, item.data_venda());
            stmt.setObject(5, item.status_pagamento());
            if (!insert) stmt.setInt(6, item.id());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new ModelException("Erro ao salvar venda", e);
        }
    }

    public void delete(int id) throws ModelException {
        try (Connection conn = MySQLConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM vendas WHERE id=?")) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new ModelException("Erro ao excluir venda", e);
        }
    }
}
