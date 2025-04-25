package org.example.servletcrudapp.dao;

import at.favre.lib.crypto.bcrypt.BCrypt;
import org.example.servletcrudapp.model.User;
import org.example.servletcrudapp.util.dbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class userDAO {

    private static final String INSERT_USER_SQL = "INSERT INTO users (username,email,mobile,password,image,status) VALUES (?,?,?,?,?,'active')";
    private static final String AUTH_QUERY = "SELECT password,status FROM users WHERE email=?";
    private static final String GET_USER_SQL = "SELECT * FROM users WHERE email=?";
    private static final String CHECK_EMAIL_SQL = "SELECT 1 FROM users WHERE email=?";
    private static final String UPDATE_USER_SQL = "UPDATE users SET username=?, mobile=?, password=?,status=? WHERE email=?";
    private static final String DELETE_USER_SQL = "DELETE FROM users WHERE email=?";
    private static final String GET_ALL_USER_SQL = "SELECT * FROM users";

    //register specific user
    public void insertUser(User user) {
        try (Connection connection = dbUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getMobile());
            preparedStatement.setString(4, user.getPassword());

            if(user.getImage() != null){
                preparedStatement.setBytes(5, user.getImage());
            }
            else{
                preparedStatement.setNull(5, java.sql.Types.BLOB);
            }

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //check users email exists
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

    //authenticate and check users access status
    public boolean authenticateUser(String email, String password) {
        try (Connection connection = dbUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(AUTH_QUERY)) {

            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();
            if(rs.next()) {
                String hashedPassword = rs.getString("password");
                String status = rs.getString("status");

                //check is the user not-active
                if(!"active".equalsIgnoreCase(status)) {
                    return false;
                }

                BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), hashedPassword);
                return result.verified;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //get specific user data for profile
    public User getUserByEmail(String email){
        try (Connection connection = dbUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_SQL)) {

            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();

            if(rs.next()){
                String username = rs.getString("username");
                String password = rs.getString("password");
                String mobile = rs.getString("mobile");
                byte[] image = rs.getBytes("image");
                String status = rs.getString("status");
                return new User(username,email,mobile,password,image,status);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //update specific user
    public boolean updateUser(User user) {
        try (Connection connection = dbUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_SQL)) {

            String password = user.getPassword();

            // Only hash if it's not already hashed (assuming hashed passwords start with $2a$)
            if (!password.startsWith("$2a$")) {
                password = BCrypt.withDefaults().hashToString(12, password.toCharArray());
            }

            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getMobile());
            preparedStatement.setString(3, password);
            preparedStatement.setString(4,user.getStatus());
            preparedStatement.setString(5, user.getEmail());



            int rowsUpdated = preparedStatement.executeUpdate();

            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean deleteUserByEmail(String email){
        try(Connection connection = dbUtil.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER_SQL)){

            preparedStatement.setString(1, email);

            int rowsUpdated = preparedStatement.executeUpdate();

            return rowsUpdated > 0;
        }
        catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public List<User> getAllUsers(){

        List<User> users = new ArrayList<>();

        try (Connection connection = dbUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_USER_SQL)) {

            ResultSet rs = preparedStatement.executeQuery();

            while(rs.next()){
                String username = rs.getString("username");
                String email = rs.getString("email");
                String mobile = rs.getString("mobile");
                String password = rs.getString("password");
                byte[] image = rs.getBytes("image");
                String status = rs.getString("status");

                users.add(new User(username,email,mobile,password,image,status));
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        return users;

    }



}
