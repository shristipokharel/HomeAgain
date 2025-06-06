package com.example.homeagain.controller;

import com.example.homeagain.dao.UserDAO;
import com.example.homeagain.dao.ItemDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/delete-user")
public class AdminDeleteUserServlet extends HttpServlet {
    private UserDAO userDAO;
    private ItemDAO itemDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userId = request.getParameter("id");
        if (userId != null && !userId.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(userId);
                
                // First delete all items posted by the user
                itemDAO.deleteItemsByUserId(id);
                
                // Then delete the user
                if (userDAO.deleteUser(id)) {
                    response.sendRedirect(request.getContextPath() + "/admin/users?deleteSuccess=true");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/users?deleteError=true");
                }
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/users?deleteError=true");
    }
} 