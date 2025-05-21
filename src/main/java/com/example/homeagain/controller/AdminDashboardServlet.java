package com.example.homeagain.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Comparator;

import com.example.homeagain.dao.UserDAO;
import com.example.homeagain.dao.ItemDAO;
import com.example.homeagain.dao.ContactDAO;
import com.example.homeagain.model.Item;
import com.example.homeagain.model.User;
import com.example.homeagain.model.Contact;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO;
    private ItemDAO itemDAO;
    private ContactDAO contactDAO;

    public void init() {
        userDAO = new UserDAO();
        itemDAO = new ItemDAO();
        contactDAO = new ContactDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        try {
            // Get counts from DAOs
            int totalUsers = userDAO.getTotalUsers(); // Assuming this method exists
            int activeUsers = userDAO.getActiveUsersCount(); // Assuming this method exists
            int inactiveUsers = totalUsers - activeUsers;
            int approvedItems = itemDAO.getItemsCountByStatus("approved"); // Assuming this method exists
            int rejectedItems = itemDAO.getItemsCountByStatus("rejected"); // Assuming this method exists
            int totalContacts = contactDAO.getTotalContacts(); // Assuming this method exists

            // Get recent activities (fetching more than 7 to ensure we have enough for the top 7 after combining)
            List<Item> recentApprovedItems = itemDAO.getRecentItemsByStatus("approved", 10);
            List<Item> recentRejectedItems = itemDAO.getRecentItemsByStatus("rejected", 10);
            List<User> recentUsers = userDAO.getRecentUsers(10);
            List<Contact> recentContacts = contactDAO.getRecentContacts(10);

            // Combine all recent activities into a single list of objects with timestamps
            List<Object[]> recentActivities = new ArrayList<>();

            for (Item item : recentApprovedItems) {
                recentActivities.add(new Object[]{item.getPostedAt(), "item", "approved", item.getTitle(), item.getId()});
            }
            for (Item item : recentRejectedItems) {
                recentActivities.add(new Object[]{item.getPostedAt(), "item", "rejected", item.getTitle(), item.getId()});
            }
            for (User user : recentUsers) {
                recentActivities.add(new Object[]{user.getCreatedAt(), "user", "registered", user.getUsername()});
            }
            for (Contact contact : recentContacts) {
                recentActivities.add(new Object[]{contact.getCreatedAt(), "contact", "received", contact.getName()});
            }

            // Sort the combined list by timestamp in descending order
            recentActivities.sort(Comparator.comparing(obj -> (java.sql.Timestamp) obj[0], Comparator.reverseOrder()));

            // Limit the list to the top 7
            List<Object[]> top7RecentActivities = recentActivities.size() > 7 ? recentActivities.subList(0, 7) : recentActivities;

            // Set the top 7 recent activities as a request attribute
            request.setAttribute("top7RecentActivities", top7RecentActivities);

            // Set counts as request attributes
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("activeUsers", activeUsers);
            request.setAttribute("inactiveUsers", inactiveUsers);
            request.setAttribute("approvedItems", approvedItems);
            request.setAttribute("rejectedItems", rejectedItems);
            request.setAttribute("totalContacts", totalContacts);

            // Forward to admin dashboard page
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions and potentially show an error message on the dashboard
            request.setAttribute("error", "Error loading dashboard data: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
        }
    }
} 