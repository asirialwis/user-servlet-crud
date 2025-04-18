package org.example.servletcrudapp.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.servletcrudapp.dao.userDAO;

import java.io.IOException;

@WebServlet("/delete")
public class DeleteAccountServlet extends HttpServlet {
    private final userDAO dao = new userDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String email = null;

        if (session != null) {
            email = (String) session.getAttribute("user");
        }


        if (email != null && dao.deleteUserByEmail(email)) {
            // Invalidate session
            session.invalidate();

            // Delete the "remember" cookie if it exists
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("remember".equals(cookie.getName())) {
                        cookie.setMaxAge(0);
                        cookie.setPath("/servletCrudApp_war_exploded");
                        response.addCookie(cookie);
                        break;
                    }
                }
            }

            response.sendRedirect("register.jsp?message=You have successfully deleted your account");
        }
        else{
            response.sendRedirect("profile?error=Failed to delete your account");
        }
    }
}
