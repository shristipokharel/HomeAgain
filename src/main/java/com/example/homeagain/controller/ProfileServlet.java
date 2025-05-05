package com.example.homeagain.controller;

import com.example.homeagain.dao.UserDAO;
import com.example.homeagain.dao.ItemDAO;
import com.example.homeagain.model.User;
import com.example.homeagain.model.Item;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProfileServlet", value = "/profile")
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO;
    private ItemDAO itemDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<Item> userItems = itemDAO.getItemsByUserId(user.getId());
        
        request.setAttribute("user", user);
        request.setAttribute("userItems", userItems);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/profile.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle profile updates if needed
    }
} 