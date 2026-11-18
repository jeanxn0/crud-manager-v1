package model.dao;

import java.sql.*;
import java.math.BigDecimal;
import model.DashboardStats;
import model.ModelException;

public class DashboardDAO {
    public DashboardStats summary() throws ModelException {
        try (Connection conn = MySQLConnectionFactory.getConnection()) {
            return new DashboardStats(
                    count(conn, "jogos"), count(conn, "vendas"),
                    countWhere(conn, "vendas", "status_pagamento = 'PENDENTE'"),
                    count(conn, "contas"), count(conn, "users"),
                    count(conn, "companies"), count(conn, "posts"), revenue(conn)
            );
        } catch (SQLException e) {
            throw new ModelException("Falha na conexão com o banco de dados do painel", e);
        }
    }

    private long count(Connection c, String table) throws SQLException {
        return countWhere(c, table, "1=1");
    }

    private long countWhere(Connection c, String table, String condition) throws SQLException {
        // table/condition usados somente com constantes internas, nunca com entrada do usuário.
        try (PreparedStatement statement = c.prepareStatement(
                "SELECT COUNT(*) FROM " + table + " WHERE " + condition);
             ResultSet rs = statement.executeQuery()) {
            rs.next();
            return rs.getLong(1);
        } catch (SQLException e) {
            if (e.getErrorCode() == 1146) return 0L; // tabela ainda não criada
            throw e;
        }
    }

    private BigDecimal revenue(Connection c) throws SQLException {
        try (PreparedStatement statement = c.prepareStatement(
                "SELECT COALESCE(SUM(valor_total), 0) FROM vendas WHERE status_pagamento='PAGO'");
             ResultSet rs = statement.executeQuery()) {
            rs.next();
            return rs.getBigDecimal(1);
        } catch (SQLException e) {
            if (e.getErrorCode() == 1146) return BigDecimal.ZERO;
            throw e;
        }
    }
}
