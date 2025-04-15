package org.example.servletcrudapp.servlet;

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

    protected void doPost(HttpServletRequest request, HttpServletResponse response){
        String username  = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User(username, password, email);
        dao.insertUser(user);


        try {
            response.setContentType("text/html");
            response.getWriter().println("<h2>User Registered Successfully</h2>");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
