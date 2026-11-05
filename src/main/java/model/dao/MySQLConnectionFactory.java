package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import model.ModelException;

public class MySQLConnectionFactory {

    private static final String JDBC_DRIVER_NAME =
            "com.mysql.cj.jdbc.Driver";

    private static final String DATABASE_URL =
            "jdbc:mysql://trabalho-jeansantosc27-f68c.b.aivencloud.com:10001/crud_manager?sslMode=REQUIRED";

    private static final String USER = "avnadmin";

    private static final String PASSWORD = "Senha";

    public static Connection getConnection() throws ModelException {

        try {
            Class.forName(JDBC_DRIVER_NAME);

            return DriverManager.getConnection(
                    DATABASE_URL,
                    USER,
                    PASSWORD
            );

        } catch (ClassNotFoundException e) {
            throw new ModelException("Driver não encontrado", e);

        } catch (SQLException e) {
            throw new ModelException(
                    "Falha na conexão com o BD: " + e.getMessage(), e);
        }
    }
}