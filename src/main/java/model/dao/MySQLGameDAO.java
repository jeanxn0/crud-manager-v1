package model.dao;

import java.sql.*;
import java.util.*;
import java.time.*;
import java.math.BigDecimal;
import model.Game;
import model.ModelException;

public class MySQLGameDAO implements GameDAO {
    public List<Game> list() throws ModelException {
        List<Game> rows = new ArrayList<>();
        try (Connection connection = MySQLConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT * FROM jogos ORDER BY id DESC");
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                rows.add(new Game(rs.getInt("id"), rs.getObject("titulo", String.class), rs.getObject("descricao", String.class), rs.getObject("data_lancamento", LocalDate.class), rs.getObject("preco", BigDecimal.class), rs.getObject("usuario_id", Integer.class)));
            }
            return rows;
        } catch (SQLException e) {
            throw new ModelException("Erro ao listar registros", e);
        }
    }

    public Map<Integer, String> options() throws ModelException {
        Map<Integer, String> labels = new LinkedHashMap<>();
        try (Connection connection = MySQLConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT id,nome FROM users ORDER BY nome");
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) labels.put(rs.getInt(1), rs.getString(2));
            return labels;
        } catch (SQLException e) {
            throw new ModelException("Erro ao carregar opções", e);
        }
    }

    public void save(Game item) throws ModelException {
        boolean insert = item.id() == 0;
        String sql = insert ? "INSERT INTO jogos (titulo, descricao, data_lancamento, preco, usuario_id) VALUES (?, ?, ?, ?, ?)"
                            : "UPDATE jogos SET titulo=?, descricao=?, data_lancamento=?, preco=?, usuario_id=? WHERE id=?";
        try (Connection connection = MySQLConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, item.titulo());
            statement.setObject(2, item.descricao());
            statement.setObject(3, item.data_lancamento());
            statement.setObject(4, item.preco());
            statement.setObject(5, item.usuario_id());
            if (!insert) statement.setInt(6, item.id());
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new ModelException("Erro ao salvar registro", e);
        }
    }

    public void delete(int id) throws ModelException {
        try (Connection connection = MySQLConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement("DELETE FROM jogos WHERE id=?")) {
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new ModelException("Erro ao excluir registro", e);
        }
    }
}
