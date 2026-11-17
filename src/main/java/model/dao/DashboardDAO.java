package model.dao;

import java.sql.*;
import model.DashboardStats;
import model.ModelException;

public class DashboardDAO {
    public DashboardStats summary() throws ModelException {
        String sql = "SELECT "
                + "(SELECT COUNT(*) FROM jogos) games, "
                + "(SELECT COUNT(*) FROM vendas) orders_count, "
                + "(SELECT COUNT(*) FROM vendas WHERE status_pagamento='PENDENTE') pending_count, "
                + "(SELECT COUNT(*) FROM contas) accounts_count, "
                + "(SELECT COUNT(*) FROM users) users_count, "
                + "(SELECT COUNT(*) FROM companies) companies_count, "
                + "(SELECT COUNT(*) FROM posts) posts_count, "
                + "(SELECT COALESCE(SUM(valor_total), 0) FROM vendas WHERE status_pagamento='PAGO') revenue";
        try (Connection conn = MySQLConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            rs.next();
            return new DashboardStats(rs.getLong("games"), rs.getLong("orders_count"),
                    rs.getLong("pending_count"), rs.getLong("accounts_count"),
                    rs.getLong("users_count"), rs.getLong("companies_count"),
                    rs.getLong("posts_count"), rs.getBigDecimal("revenue"));
        } catch (SQLException e) {
            throw new ModelException("Falha ao carregar indicadores do painel", e);
        }
    }
}
