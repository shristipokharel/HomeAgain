package com.example.homeagain.controller;

import com.example.homeagain.dao.ItemDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/delete-item")
public class AdminDeleteItemServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() {
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

        String itemId = request.getParameter("id");
        if (itemId != null && !itemId.trim().isEmpty()) {
            try {
                if (itemDAO.deleteItem(Integer.parseInt(itemId))) {
                    response.sendRedirect(request.getContextPath() + "/admin/all-items?deleteSuccess=true");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/all-items?deleteError=true");
                }
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/all-items?deleteError=true");
    }
} 