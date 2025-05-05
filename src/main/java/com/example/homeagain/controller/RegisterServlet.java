package com.example.homeagain.controller;

import com.example.homeagain.dao.UserDAO;
import com.example.homeagain.model.User;
import com.example.homeagain.utils.DBConnection;
import com.example.homeagain.utils.PasswordUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Date;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO;
    
    public void init() {
        userDAO = new UserDAO();
        
        // Test database connection on servlet init
        try {
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                System.out.println("Database connection successful in RegisterServlet init!");
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Database connection FAILED in RegisterServlet init: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to registration page
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get form parameters
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            
            // Log registration attempt
            System.out.println("Registration attempt - Username: " + username + ", Email: " + email);
            
            // Validate input
            if (username == null || username.isEmpty() || 
                password == null || password.isEmpty() ||
                confirmPassword == null || confirmPassword.isEmpty() ||
                email == null || email.isEmpty() ||
                fullName == null || fullName.isEmpty() ||
                phoneNumber == null || phoneNumber.isEmpty()) {
                
                request.setAttribute("errorMessage", "All fields are required");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
            
            // Check if passwords match
            if (!password.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Passwords do not match");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
            
            // Check database connection
            if (!DBConnection.testConnection()) {
                request.setAttribute("errorMessage", "Database connection failed. Please contact administrator.");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
            
            // Check if username already exists
            User existingUserByUsername = userDAO.getUserByUsername(username);
            if (existingUserByUsername != null) {
                request.setAttribute("errorMessage", "Username already exists");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
            
            // Check if email already exists
            User existingUserByEmail = userDAO.getUserByEmail(email);
            if (existingUserByEmail != null) {
                request.setAttribute("errorMessage", "Email already exists");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
            
            // Generate salt and hash password
            String salt = PasswordUtils.generateSalt();
            String hashedPassword = PasswordUtils.hashPassword(password, salt);
            
            // Create user object
            User user = new User(
                0, // ID will be assigned by database
                username,
                hashedPassword, // Store the hashed password
                email,
                fullName,
                phoneNumber,
                true, // is_active
                new Timestamp(new Date().getTime()) // created_at
            );
            user.setSalt(salt); // Set the salt
            
            // Save user to database
            boolean success = userDAO.createUser(user);
            
            if (success) {
                // Registration successful
                System.out.println("Registration successful for user: " + username);
                request.setAttribute("successMessage", "Registration successful! Please login.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            } else {
                // Registration failed
                System.out.println("Registration failed for user: " + username);
                request.setAttribute("errorMessage", "Registration failed. Database operation unsuccessful.");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Log the error
            System.err.println("Error in RegisterServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Show a user-friendly error message
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
} 