package com.example.homeagain.controller;

import com.example.homeagain.dao.ItemDAO;
import com.example.homeagain.model.Item;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "EditItemServlet", value = "/edit-item")
public class EditItemServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String itemId = request.getParameter("id");
        if (itemId != null && !itemId.trim().isEmpty()) {
            Item item = itemDAO.getItemById(Integer.parseInt(itemId));
            if (item != null) {
                request.setAttribute("item", item);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/edit-item.jsp");
                dispatcher.forward(request, response);
                return;
            }
        }
        response.sendRedirect("profile");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String itemId = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");

        if (itemId != null && !itemId.trim().isEmpty()) {
            Item item = itemDAO.getItemById(Integer.parseInt(itemId));
            if (item != null) {
                item.setTitle(title);
                item.setDescription(description);
                item.setLocation(location);

                if (itemDAO.updateItem(item)) {
                    response.sendRedirect("profile?success=true");
                } else {
                    response.sendRedirect("edit-item?id=" + itemId + "&error=true");
                }
                return;
            }
        }
        response.sendRedirect("profile");
    }
} 