package com.example.homeagain.controller;

import com.example.homeagain.dao.ContactDAO;
import com.example.homeagain.model.Contact;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/contacts")
public class AdminContactsServlet extends HttpServlet {
    private ContactDAO contactDAO;

    @Override
    public void init() {
        contactDAO = new ContactDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get all contacts
        List<Contact> contacts = contactDAO.getAllContacts();
        request.setAttribute("contacts", contacts);

        // Forward to admin contacts page
        request.getRequestDispatcher("/WEB-INF/views/admin/admin-contacts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        int contactId = Integer.parseInt(request.getParameter("id"));

        if ("delete".equals(action)) {
            boolean deleted = contactDAO.deleteContact(contactId);
            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/admin/contacts?deleted=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/contacts?error=true&message=Failed to delete message");
            }
            return;
        }

        // Default redirect
        response.sendRedirect(request.getContextPath() + "/admin/contacts");
    }
} 