package org.example.servletcrudapp.dao;

import at.favre.lib.crypto.bcrypt.BCrypt;
import org.example.servletcrudapp.model.User;
import org.example.servletcrudapp.util.dbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class userDAO {

    private static final String INSERT_USER_SQL = "INSERT INTO users (username,email,mobile,password) VALUES (?,?,?,?)";
    private static final String AUTH_QUERY = "SELECT password FROM users WHERE email=?";
    private static final String GET_USER_SQL = "SELECT * FROM users WHERE email=?";
    private static final String CHECK_EMAIL_SQL = "SELECT 1 FROM users WHERE email=?";
    private static final String UPDATE_USER_SQL = "UPDATE users SET username=?, mobile=?, password=? WHERE email=?";

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
    public boolean emailExists(String email)  {
        try (Connection connection = dbUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(CHECK_EMAIL_SQL)){
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();   //return true if email exists
        }
        catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean authenticateUser(String email, String password) {
        try (Connection connection = dbUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(AUTH_QUERY)) {

            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();
            if(rs.next()) {
                String hashedPassword = rs.getString("password");
                BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), hashedPassword);
                return result.verified;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserByEmail(String email){
        try (Connection connection = dbUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_SQL)) {

            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();

            if(rs.next()){
                String username = rs.getString("username");
                String password = rs.getString("password");
                int mobile = rs.getInt("mobile");
                return new User(username,email,mobile,password);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUser(User user) {
        try (Connection connection = dbUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_SQL)) {

            String password = user.getPassword();

            // Only hash if it's not already hashed (assuming hashed passwords start with $2a$)
            if (!password.startsWith("$2a$")) {
                password = BCrypt.withDefaults().hashToString(12, password.toCharArray());
            }

            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setInt(2, user.getMobile());
            preparedStatement.setString(3, password);
            preparedStatement.setString(4, user.getEmail());



            int rowsUpdated = preparedStatement.executeUpdate();

            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }


    }

}
