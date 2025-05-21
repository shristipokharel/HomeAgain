package com.example.homeagain.controller;

import com.example.homeagain.dao.ItemDAO;
import com.example.homeagain.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/lost")
public class LostServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() throws ServletException {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Item> lostItems = itemDAO.getItemsByPostType("lost");
        request.setAttribute("lostItems", lostItems);
        request.getRequestDispatcher("/WEB-INF/views/Lost.jsp").forward(request, response);
    }
} 