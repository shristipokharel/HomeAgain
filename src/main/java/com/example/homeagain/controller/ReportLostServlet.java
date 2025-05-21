package com.example.homeagain.controller;

import com.example.homeagain.dao.CategoryDAO;
import com.example.homeagain.dao.ItemDAO;
import com.example.homeagain.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/report-lost")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 5 * 1024 * 1024,   // 5 MB
        maxRequestSize = 10 * 1024 * 1024 // 10 MB
)
public class ReportLostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(ReportLostServlet.class.getName());
    private ItemDAO itemDAO;
    private CategoryDAO categoryDAO;
    
    @Override
    public void init() throws ServletException {
        itemDAO = new ItemDAO();
        categoryDAO = new CategoryDAO();
        // Insert default categories if none exist
        categoryDAO.insertDefaultCategories();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Load categories for the dropdown
        request.setAttribute("categories", categoryDAO.getAllCategories());
        
        // Forward to report lost page
        request.getRequestDispatcher("/WEB-INF/views/ReportLost.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("DEBUG: Entered doPost in ReportLostServlet");
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get form data
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String dateLostStr = request.getParameter("dateLost");
        String timeLostStr = request.getParameter("timeLost");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String contactNumber = request.getParameter("contactNumber");

        LOGGER.info("Received lost item report: " + itemName + " in category " + category);

        // Validate required fields
        if (itemName == null || itemName.trim().isEmpty() ||
                category == null || category.trim().isEmpty() ||
                dateLostStr == null || dateLostStr.trim().isEmpty() ||
                location == null || location.trim().isEmpty() ||
                description == null || description.trim().isEmpty() ||
                contactNumber == null || contactNumber.trim().isEmpty()) {

            LOGGER.warning("Missing required fields in lost item report");
            request.setAttribute("error", "Please fill all required fields");
            request.getRequestDispatcher("/WEB-INF/views/ReportLost.jsp").forward(request, response);
            return;
        }

        try {
            // Handle file upload
            String imagePath = null;
            Part filePart = request.getPart("itemImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // Create uploads directory if it doesn't exist
                    String uploadPath = getServletContext().getRealPath("/uploads");
                    Files.createDirectories(Paths.get(uploadPath));
                    
                    // Save the file
                    String fullPath = uploadPath + "/" + fileName;
                    filePart.write(fullPath);
                    imagePath = "uploads/" + fileName;
                }
            }

            // Create Item object
            Item item = new Item();
            item.setTitle(itemName);
            item.setDescription(description);
            item.setCategoryId(Integer.parseInt(category));
            item.setImageUrl(imagePath);
            item.setLocation(location);
            item.setPostType("lost"); // Set type as lost
            item.setStatus("pending"); // Initial status is pending
            item.setUserId((Integer) session.getAttribute("userId")); // Get user ID from session
            item.setPostedAt(new Timestamp(System.currentTimeMillis()));

            LOGGER.info("Creating lost item with title: " + itemName + " for user: " + item.getUserId());

            // Save to database
            boolean success = itemDAO.createItem(item);

            if (success) {
                LOGGER.info("Lost item created successfully with ID: " + item.getId());
                request.setAttribute("message", "Your lost item has been reported successfully!");
                response.sendRedirect(request.getContextPath() + "/lost");
            } else {
                LOGGER.warning("Failed to create lost item");
                request.setAttribute("error", "Failed to save the lost item report. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/ReportLost.jsp").forward(request, response);
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing lost item report", e);
            request.setAttribute("error", "Error processing your request: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/ReportLost.jsp").forward(request, response);
        }
    }

    // Helper method to extract file name from HTTP header content-disposition
    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        for (String content : partHeader.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
} 