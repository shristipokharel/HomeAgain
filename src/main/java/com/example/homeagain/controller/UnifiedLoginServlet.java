package com.example.homeagain.controller;

import com.example.homeagain.dao.AdminDAO;
import com.example.homeagain.dao.UserDAO;
import com.example.homeagain.model.Admin;
import com.example.homeagain.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/login")
public class UnifiedLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(UnifiedLoginServlet.class.getName());
    
    private UserDAO userDAO;
    private AdminDAO adminDAO;
    
    public void init() {
        userDAO = new UserDAO();
        adminDAO = new AdminDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if already logged in as user
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        // Check if already logged in as admin
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        try {
            if ("admin".equals(role)) {
                // Admin authentication
                Admin admin = adminDAO.authenticateAdmin(username, password);
                if (admin != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("admin", admin);
                    session.setAttribute("adminId", admin.getId());
                    session.setAttribute("adminUsername", admin.getUsername());
                    LOGGER.info("Admin logged in successfully with ID: " + admin.getId());
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    request.setAttribute("errorMessage", "Invalid admin credentials");
                    request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                }
            } else {
                // User authentication
                User user = userDAO.authenticateUser(username, password);
                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    session.setAttribute("userId", user.getId());
                    LOGGER.info("User logged in successfully with ID: " + user.getId());
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                } else {
                    request.setAttribute("errorMessage", "Invalid user credentials");
                    request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Login failed", e);
            request.setAttribute("errorMessage", "Login failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
