package org.example.servletcrudapp.servlet;


import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.example.servletcrudapp.dao.userDAO;
import org.example.servletcrudapp.model.User;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/adduser")
@MultipartConfig
public class AddUserServlet extends HttpServlet {
    private final userDAO dao = new userDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String username  = request.getParameter("username");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");

//        if (password == null || password.isEmpty()) {
//            // You can either:
//            response.sendRedirect("register.jsp?error=missingPassword");
//            return; // Stop further execution
//        }
        Part filePart = request.getPart("image");

        byte[] imageBytes = null;
        if (filePart != null && filePart.getSize() > 0) {
            imageBytes = filePart.getInputStream().readAllBytes();
        }

        String hashedPassword = BCrypt.withDefaults().hashToString(12, password.toCharArray());

        User user = new User(username,email,mobile,hashedPassword,imageBytes);

        //Check the email exists in users table
        if(dao.emailExists(email)){
           try{
               response.sendRedirect("register.jsp?error=emailAlreadyExists");
           }
           catch(IOException e){
               throw new RuntimeException();
           }
        }
        //if not exists email then insert user data
        else{
            dao.insertUser(user);
            response.sendRedirect("login.jsp");
        }


    }
}
