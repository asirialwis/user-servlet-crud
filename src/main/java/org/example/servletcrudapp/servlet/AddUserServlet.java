package org.example.servletcrudapp.servlet;


import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.example.servletcrudapp.dao.userDAO;
import org.example.servletcrudapp.model.User;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/adduser")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,  // 1MB
        maxFileSize = 1024 * 1024 * 5,    // 5MB
        maxRequestSize = 1024 * 1024 * 10)
public class AddUserServlet extends HttpServlet {
    private final userDAO dao = new userDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String uploadPath = request.getServletContext().getRealPath("")+ File.separator+"upload";
        File newFile = new File(uploadPath);

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        Part filePart = request.getPart("image");

        String imagePath = "upload/default.png";



        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            imagePath = "upload/" + fileName;
            filePart.write(uploadPath + File.separator + fileName);
        }

        String username  = request.getParameter("username");
        String email = request.getParameter("email");
        int mobile = Integer.parseInt(request.getParameter("mobile"));
        String password = request.getParameter("password");

        String hashedPassword = BCrypt.withDefaults().hashToString(12, password.toCharArray());

        User user = new User(username,email,mobile,hashedPassword,imagePath);

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
