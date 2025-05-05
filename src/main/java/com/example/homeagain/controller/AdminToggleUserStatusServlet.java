package com.example.homeagain.controller;

import com.example.homeagain.dao.UserDAO;
import com.example.homeagain.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/toggle-user-status")
public class AdminToggleUserStatusServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userId = request.getParameter("userId");
        String activeStr = request.getParameter("active");

        if (userId != null && !userId.trim().isEmpty() && activeStr != null) {
            try {
                User user = userDAO.getUserById(Integer.parseInt(userId));
                if (user != null) {
                    boolean newStatus = Boolean.parseBoolean(activeStr);
                    user.setActive(newStatus);
                    
                    if (userDAO.updateUser(user)) {
                        response.sendRedirect(request.getContextPath() + "/admin/users?success=true&message=" + 
                            (newStatus ? "User activated successfully" : "User deactivated successfully"));
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/users?error=true&message=Failed to update user status");
                    }
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/users?error=true&message=Invalid request");
    }
} 