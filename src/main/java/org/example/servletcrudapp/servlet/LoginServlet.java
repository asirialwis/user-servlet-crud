package org.example.servletcrudapp.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.servletcrudapp.dao.userDAO;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final userDAO dao = new userDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean isAuthenticated = dao.authenticateUser(email , password);
        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("user", email);


            //store email in the session
            response.sendRedirect("index.jsp");   //Navigate to the home
        }
        else{
            response.sendRedirect("login.jsp?error=invalid");
        }

    }
}


