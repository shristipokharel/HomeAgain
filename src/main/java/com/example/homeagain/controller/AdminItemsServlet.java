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
import java.util.List;

@WebServlet("/admin/items")
public class AdminItemsServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() throws ServletException {
        itemDAO = new ItemDAO();
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
            List<Item> pendingItems = itemDAO.getItemsByStatus("pending");
            request.setAttribute("pendingItems", pendingItems);
            request.getRequestDispatcher("/WEB-INF/views/admin/admin-items.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading pending items: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/admin-items.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String itemId = request.getParameter("itemId");
        String rejectionReason = request.getParameter("rejectionReason");

        if (itemId != null && !itemId.trim().isEmpty()) {
            try {
                Item item = itemDAO.getItemById(Integer.parseInt(itemId));
                if (item != null) {
                    if ("approve".equals(action)) {
                        item.setStatus("approved");
                        if (itemDAO.updateItem(item)) {
                            response.sendRedirect(request.getContextPath() + "/admin/items?success=true");
                        } else {
                            request.setAttribute("error", "Failed to approve item");
                            doGet(request, response);
                        }
                    } else if ("reject".equals(action)) {
                        item.setStatus("rejected");
                        item.setRejectionReason(rejectionReason);
                        if (itemDAO.updateItem(item)) {
                            response.sendRedirect(request.getContextPath() + "/admin/items?success=true");
                        } else {
                            request.setAttribute("error", "Failed to reject item");
                            doGet(request, response);
                        }
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("error", "Invalid item ID");
                doGet(request, response);
            }
        } else {
            request.setAttribute("error", "No item ID provided");
            doGet(request, response);
        }
    }
} 