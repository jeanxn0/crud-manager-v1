package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import model.CustomerAccount;
import model.ModelException;
import model.Post;
import model.User;


public class MySQLPostDAO implements PostDAO {

    private static final String SELECT = "SELECT p.id, p.content, p.post_date, "
            + "p.user_id, p.conta_id, a.nome AS conta_nome, a.sexo AS conta_sexo, "
            + "a.email AS conta_email, u.nome AS user_nome, u.sexo AS user_sexo, "
            + "u.email AS user_email FROM posts p "
            + "LEFT JOIN contas a ON a.id = p.conta_id "
            + "LEFT JOIN users u ON u.id = p.user_id ";

    @Override
    public boolean save(Post post) throws ModelException {
        String sql = "INSERT INTO posts (content, post_date, user_id, conta_id) "
                + "VALUES (?, CURDATE(), NULL, ?)";
        try (Connection connection = open();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, post.getContent());
            statement.setInt(2, post.getAccountId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new ModelException("Falha ao cadastrar post", e);
        }
    }

    @Override
    public boolean update(Post post) throws ModelException {
        String sql = "UPDATE posts SET content=?, user_id=NULL, conta_id=? WHERE id=?";
        try (Connection connection = open();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, post.getContent());
            statement.setInt(2, post.getAccountId());
            statement.setInt(3, post.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new ModelException("Falha ao atualizar post", e);
        }
    }

    @Override
    public boolean delete(Post post) throws ModelException {
        try (Connection connection = open();
             PreparedStatement statement = connection.prepareStatement(
                     "DELETE FROM posts WHERE id=?")) {
            statement.setInt(1, post.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new ModelException("Falha ao excluir post", e);
        }
    }

    @Override
    public List<Post> listAll() throws ModelException {
        List<Post> rows = new ArrayList<>();
        try (Connection connection = open();
             PreparedStatement statement = connection.prepareStatement(
                     SELECT + "ORDER BY p.id DESC");
             ResultSet results = statement.executeQuery()) {
            while (results.next()) rows.add(from(results));
            return rows;
        } catch (SQLException e) {
            throw new ModelException("Falha ao listar posts", e);
        }
    }

    @Override
    public Post findById(int id) throws ModelException {
        try (Connection connection = open();
             PreparedStatement statement = connection.prepareStatement(
                     SELECT + "WHERE p.id = ?")) {
            statement.setInt(1, id);
            try (ResultSet results = statement.executeQuery()) {
                return results.next() ? from(results) : null;
            }
        } catch (SQLException e) {
            throw new ModelException("Falha ao buscar post", e);
        }
    }

    private Connection open() throws ModelException, SQLException {
        Connection connection = MySQLConnectionFactory.getConnection();
        try {
            CustomerRelationsSchema.ensure(connection, "posts");
            return connection;
        } catch (SQLException e) {
            connection.close();
            throw e;
        }
    }

    private Post from(ResultSet rs) throws SQLException {
        Post post = new Post(rs.getInt("id"));
        post.setContent(rs.getString("content"));
        post.setPostDate(rs.getDate("post_date"));
        int accountId = rs.getInt("conta_id");
        if (!rs.wasNull()) {
            post.setAccountId(accountId);
            post.setAccount(new CustomerAccount(accountId,
                    rs.getString("conta_nome"), rs.getString("conta_sexo"),
                    rs.getString("conta_email")));
        }
        int legacyId = rs.getInt("user_id");
        if (!rs.wasNull()) {
            User legacy = new User(legacyId);
            legacy.setName(rs.getString("user_nome"));
            legacy.setGender(rs.getString("user_sexo"));
            legacy.setEmail(rs.getString("user_email"));
            post.setUser(legacy);
        }
        return post;
    }
}
