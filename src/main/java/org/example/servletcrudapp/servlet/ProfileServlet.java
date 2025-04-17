package org.example.servletcrudapp.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.servletcrudapp.dao.userDAO;
import org.example.servletcrudapp.model.User;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private  final userDAO dao = new userDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        String email = null;

        if(session != null && session.getAttribute("user") != null){
            email = (String) session.getAttribute("user");


        }
        else{
            Cookie[] cookies = request.getCookies();
            if(cookies != null){
                for(Cookie cookie : cookies){
                    if("remember".equals(cookie.getName())){
                        email = cookie.getValue();

                        session = request.getSession();
                        session.setAttribute("user",email);
                        break;
                    }
                }
            }
        }
        //load user data or re-direct
        if(email != null){
            User user = dao.getUserByEmail(email);

            request.setAttribute("userData", user);
            request.getRequestDispatcher("user-list.jsp").forward(request,response);
        }
        else{
            response.sendRedirect("login.jsp");
        }


    }
}
