package org.example.servletcrudapp.servlet;
import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.servletcrudapp.dao.userDAO;
import org.example.servletcrudapp.model.User;
import java.io.IOException;

@WebServlet("/update")
public class UpdateServlet extends HttpServlet {
    private final userDAO dao = new userDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String status = request.getParameter("status");

        System.out.println(status);

        if (password == null || password.isEmpty()) {
            // Retrieve current password from DB
            User existingUser = dao.getUserByEmail(email);
            password = existingUser.getPassword();
        }

        User user = new User(username,email,mobile,password, status);

        boolean isUpdated = dao.updateUser(user);

        System.out.println(isUpdated);

        if(isUpdated){
            response.sendRedirect("users");
        }
        else{
            response.sendRedirect("update.jsp?error=updateFailed");
        }

    }

}
