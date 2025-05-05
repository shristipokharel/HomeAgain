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

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ContactDAO contactDAO;
    
    @Override
    public void init() {
        contactDAO = new ContactDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Forward to contact page
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get user ID from session
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        // Validate input
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            subject == null || subject.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
            return;
        }
        
        // Create contact object
        Contact contact = new Contact(name, email, subject, message, userId);
        
        // Save to database
        boolean success = contactDAO.createContact(contact);
        
        if (success) {
            session.setAttribute("contactMessage", "Your message has been sent successfully!");
        } else {
            session.setAttribute("contactMessage", "Failed to send message. Please try again.");
        }
        
        response.sendRedirect(request.getContextPath() + "/contact");
    }
} 