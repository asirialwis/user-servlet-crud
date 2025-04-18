package org.example.servletcrudapp.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);

        if(session != null){
            session.invalidate();
        }

        Cookie cookie = new Cookie("remember", "");
        cookie.setMaxAge(0); //Delete it
        response.addCookie(cookie);

        response.sendRedirect("login.jsp");
    }
}
