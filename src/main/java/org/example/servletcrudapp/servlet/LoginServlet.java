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
        String remember = request.getParameter("remember");

        boolean isAuthenticated = dao.authenticateUser(email , password);
        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("user", email);

            //set cookie if Remember Me checked
            if("true".equals(remember)){
                Cookie cookie = new Cookie("remember", email);
                cookie.setMaxAge(60*60*24*7);         //7 day valid
                response.addCookie(cookie);
            }

            //store email in the session
            response.sendRedirect("index.jsp");   //Navigate to the profile servlet
        }
        else{
            response.sendRedirect("login.jsp?error=invalid");
        }

    }
}


