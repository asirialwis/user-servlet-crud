package org.example.servletcrudapp.servlet;


import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.servletcrudapp.dao.userDAO;
import org.example.servletcrudapp.model.User;

import java.io.IOException;

@WebServlet("/adduser")
public class AddUserServlet extends HttpServlet {
    private final userDAO dao = new userDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username  = request.getParameter("username");
        String email = request.getParameter("email");
        int mobile = Integer.parseInt(request.getParameter("mobile"));
        String password = request.getParameter("password");

        String hashedPassword = BCrypt.withDefaults().hashToString(12, password.toCharArray());

        User user = new User(username,email ,mobile,hashedPassword);

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
