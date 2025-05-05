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
import java.util.List;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<User> allUsers = userDAO.getAllUsers();
            request.setAttribute("allUsers", allUsers);
            request.getRequestDispatcher("/WEB-INF/views/admin/admin-users.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading users: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/admin-users.jsp")
                    .forward(request, response);
        }
    }
} 