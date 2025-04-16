package org.example.servletcrudapp.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.servletcrudapp.dao.userDAO;
import org.example.servletcrudapp.model.User;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private  final userDAO dao = new userDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);

        if(session != null && session.getAttribute("user") != null){
            String email = (String) session.getAttribute("user");

            User user = dao.getUserByEmail(email);

            request.setAttribute("userData", user);
            request.getRequestDispatcher("user-list.jsp").forward(request,response);
        }
        else{
            response.sendRedirect("login.jsp");
        }


    }
}
