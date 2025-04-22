package org.example.servletcrudapp.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.servletcrudapp.dao.userDAO;

import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {
    private final userDAO dao = new userDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        if(email != null && !email.isEmpty()){
            boolean deleted = dao.deleteUserByEmail(email);

            if(deleted){
                response.sendRedirect("users");
            }
            else{
                response.sendRedirect("users");
            }
        }
    }
}
