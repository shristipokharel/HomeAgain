package com.example.homeagain.controller;

import com.example.homeagain.dao.ItemDAO;
import com.example.homeagain.model.Item;
import com.example.homeagain.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "DeleteItemServlet", value = "/delete-item")
public class DeleteItemServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String itemId = request.getParameter("id");

        if (itemId != null && !itemId.trim().isEmpty()) {
            Item item = itemDAO.getItemById(Integer.parseInt(itemId));
            
            // Verify that the item belongs to the current user
            if (item != null && item.getUserId() == currentUser.getId()) {
                if (itemDAO.deleteItem(Integer.parseInt(itemId))) {
                    response.sendRedirect("profile?deleteSuccess=true");
                } else {
                    response.sendRedirect("profile?deleteError=true");
                }
                return;
            }
        }
        response.sendRedirect("profile?deleteError=true");
    }
} 