package com.example.homeagain.controller;

import com.example.homeagain.dao.ItemDAO;
import com.example.homeagain.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/edit-item")
public class AdminEditItemServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String itemId = request.getParameter("id");
        if (itemId != null && !itemId.trim().isEmpty()) {
            try {
                Item item = itemDAO.getItemById(Integer.parseInt(itemId));
                if (item != null) {
                    request.setAttribute("item", item);
                    request.getRequestDispatcher("/WEB-INF/views/admin/edit-item.jsp")
                            .forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/all-items");
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
                Item item = itemDAO.getItemById(Integer.parseInt(itemId));
                if (item != null) {
                    // Update item fields
                    item.setTitle(request.getParameter("title"));
                    item.setDescription(request.getParameter("description"));
                    item.setLocation(request.getParameter("location"));
                    item.setStatus(request.getParameter("status"));
                    
                    if (itemDAO.updateItem(item)) {
                        response.sendRedirect(request.getContextPath() + "/admin/all-items?success=true");
                    } else {
                        request.setAttribute("error", "Failed to update item");
                        request.setAttribute("item", item);
                        request.getRequestDispatcher("/WEB-INF/views/admin/edit-item.jsp")
                                .forward(request, response);
                    }
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/all-items?error=true");
    }
} 