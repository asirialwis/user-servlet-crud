package org.example.servletcrudapp.dao;

import org.example.servletcrudapp.model.User;
import org.example.servletcrudapp.util.dbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class userDAO {

    private static final String INSERT_USER_SQL = "INSERT INTO users (username,email,mobile,password) VALUES (?,?,?,?)";
    private static final String AUTH_QUERY = "SELECT * FROM users WHERE email=? AND password=?";

    public void insertUser(User user) {
        try (Connection connection = dbUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setInt(3, user.getMobile());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean authenticateUser(String email, String password) {
        try (Connection connection = dbUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(AUTH_QUERY)) {

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet rs = preparedStatement.executeQuery();
            return rs.next(); // true if a matching record is found

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
